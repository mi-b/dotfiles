import io
import tempfile
import unittest
import zipfile
from pathlib import Path
from unittest.mock import patch

from test_inspect import WORD, office_inspect, package_parts, relationships


class WordTests(unittest.TestCase):
    def inspect(self, body, extra=None):
        parts = package_parts("docx") | {
            "word/document.xml": (
                f'<w:document xmlns:w="{WORD}"><w:body>{body}</w:body></w:document>'
            ),
        }
        parts.update(extra or {})
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "word.docx"
            with zipfile.ZipFile(path, "w") as archive:
                for name, content in parts.items():
                    archive.writestr(name, content)
            return office_inspect.inspect_file(path)

    def paragraphs(self, report, part="word/document.xml"):
        return [
            record
            for location, record in report["records"].items()
            if location.startswith(f"{part}/paragraph/")
        ]

    def test_revision_wrappers_preserve_metadata_and_explicit_view(self):
        body = "<w:p><w:r><w:t>Base </w:t></w:r>"
        for index, kind in enumerate(("ins", "del", "moveFrom", "moveTo"), 1):
            text_tag = "delText" if kind in ("del", "moveFrom") else "t"
            body += (
                f'<w:{kind} w:id="{index}" w:author="Reviewer" '
                'w:date="2026-11-03T12:00:00Z">'
                f"<w:r><w:{text_tag}>{kind} </w:{text_tag}></w:r></w:{kind}>"
            )
        report = self.inspect(
            body + "</w:p><w:p><w:r><w:delText>orphan</w:delText></w:r></w:p>"
        )
        paragraph, orphan = self.paragraphs(report)
        self.assertEqual(paragraph["text"], "Base ins moveTo ")
        self.assertEqual(paragraph["all_text"], "Base ins del moveFrom moveTo ")
        self.assertIn("not resolved revisions", paragraph["text_view"])
        self.assertEqual(orphan["text"], "")
        self.assertEqual(orphan["all_text"], "orphan")
        for index, token in enumerate(paragraph["tokens"][1:], 1):
            revision = token["revisions"][0]
            self.assertEqual(revision["kind"], token["text"].strip())
            self.assertEqual(revision["id"], str(index))
            self.assertEqual(revision["author"], "Reviewer")
            self.assertEqual(revision["date"], "2026-11-03T12:00:00Z")
            self.assertTrue(
                token["context"]["xml_path"].startswith(revision["xml_path"])
            )
        self.assertIn("does not accept or resolve", " ".join(report["warnings"]))

    def test_complex_field_spans_paragraphs_and_table_cells(self):
        report = self.inspect(
            '<w:p><w:r><w:t>Before </w:t><w:fldChar w:fldCharType="begin"/>'
            "<w:instrText> REF </w:instrText></w:r></w:p>"
            "<w:tbl><w:tr><w:tc><w:p><w:r><w:instrText>bookmark </w:instrText>"
            '<w:fldChar w:fldCharType="separate"/><w:t>Stored</w:t></w:r></w:p>'
            "</w:tc><w:tc><w:p><w:r><w:t> result</w:t>"
            '<w:fldChar w:fldCharType="end"/><w:t> after</w:t></w:r></w:p>'
            "</w:tc></w:tr></w:tbl>"
        )
        first, second, third = self.paragraphs(report)
        self.assertEqual(
            [p["text"] for p in (first, second, third)],
            ["Before ", "Stored", " result after"],
        )
        self.assertEqual(first["field_instructions"], " REF ")
        self.assertEqual(second["field_instructions"], "bookmark ")
        self.assertEqual(second["all_text"], "bookmark Stored")
        self.assertEqual(second["tokens"][0]["fields"][0]["phase"], "instruction")
        self.assertEqual(third["tokens"][0]["fields"][0]["phase"], "result")
        self.assertEqual(third["tokens"][-1]["fields"], [])
        self.assertIn("/tbl/1/tr/1/tc/2/p/1", third["context"]["xml_path"])
        self.assertFalse(
            any("without begin" in w or "no end" in w for w in report["warnings"])
        )

    def test_revision_metadata_change_is_reported_without_display_change(self):
        body = (
            '<w:moveTo w:id="8" w:author="Before" w:date="2026-11-03">'
            "<w:p><w:r><w:t>Unchanged</w:t></w:r></w:p></w:moveTo>"
        )
        before = self.inspect(body)
        after = self.inspect(body.replace('w:author="Before"', 'w:author="After"'))
        self.assertEqual(
            self.paragraphs(before)[0]["text"], self.paragraphs(after)[0]["text"]
        )
        changes = office_inspect.compare_reports(before, after)["changes"]
        self.assertEqual(len(changes), 1)
        self.assertEqual(changes[0]["location"], "word/document.xml/paragraph/1")
        self.assertEqual(changes[0]["kind"], "changed")

    def test_simple_field_instruction_is_not_display_text(self):
        paragraph = self.paragraphs(
            self.inspect(
                '<w:p><w:fldSimple w:instr=" DATE "><w:ins w:id="7" w:author="A">'
                "<w:r><w:t>3 November</w:t></w:r></w:ins></w:fldSimple>"
                "<w:r><w:tab/><w:t>end</w:t><w:br/><w:cr/></w:r></w:p>"
            )
        )[0]
        self.assertEqual(paragraph["text"], "3 November\tend\n\n")
        self.assertEqual(paragraph["field_instructions"], " DATE ")
        self.assertEqual(paragraph["all_text"], " DATE 3 November\tend\n\n")
        instruction, result = paragraph["tokens"][:2]
        self.assertEqual(instruction["role"], "field_instruction")
        self.assertEqual(result["fields"][0]["kind"], "simple")
        self.assertEqual(result["revisions"][0]["id"], "7")

    def test_nested_fields_in_instructions_and_results(self):
        paragraph = self.paragraphs(
            self.inspect(
                '<w:p><w:r><w:fldChar w:fldCharType="begin"/>'
                '<w:instrText>IF </w:instrText><w:fldChar w:fldCharType="begin"/>'
                '<w:instrText>PAGE</w:instrText><w:fldChar w:fldCharType="separate"/>'
                '<w:t>2</w:t><w:fldChar w:fldCharType="end"/>'
                '<w:instrText> = 2</w:instrText><w:fldChar w:fldCharType="separate"/>'
                '<w:t>Yes </w:t></w:r><w:fldSimple w:instr="AUTHOR">'
                "<w:r><w:t>Alice</w:t></w:r></w:fldSimple>"
                '<w:r><w:fldChar w:fldCharType="begin"/><w:instrText>PAGE</w:instrText>'
                '<w:fldChar w:fldCharType="separate"/><w:t>2</w:t>'
                '<w:fldChar w:fldCharType="end"/><w:t>!</w:t>'
                '<w:fldChar w:fldCharType="end"/></w:r></w:p>'
            )
        )[0]
        self.assertEqual(paragraph["text"], "Yes Alice2!")
        self.assertEqual(paragraph["field_instructions"], "IF PAGE2 = 2AUTHORPAGE")
        inner_result = next(t for t in paragraph["tokens"] if t["text"] == "2")
        self.assertEqual(inner_result["role"], "field_instruction")
        self.assertEqual(
            [f["phase"] for f in inner_result["fields"]], ["instruction", "result"]
        )

    def test_block_revisions_and_nested_textbox_paragraphs(self):
        report = self.inspect(
            '<w:del w:id="4" w:author="Block" w:date="2026-11-03">'
            "<w:p><w:r><w:t>First</w:t></w:r></w:p>"
            '<w:tbl><w:tr><w:tc><w:p><w:ins w:id="5" w:author="Nested">'
            "<w:r><w:t>Cell</w:t></w:r></w:ins></w:p></w:tc></w:tr></w:tbl></w:del>"
            '<w:p><w:r><w:t>Outer</w:t><w:fldChar w:fldCharType="begin"/>'
            "<w:instrText>CODE</w:instrText><w:pict><w:txbxContent>"
            "<w:p><w:r><w:t>Textbox</w:t></w:r></w:p></w:txbxContent></w:pict>"
            '<w:fldChar w:fldCharType="separate"/><w:t>Result</w:t>'
            '<w:fldChar w:fldCharType="end"/></w:r></w:p>'
        )
        first, cell, outer, inner = self.paragraphs(report)
        self.assertEqual(first["text"], "")
        self.assertEqual(cell["text"], "")
        self.assertEqual(first["context"]["revisions"], cell["context"]["revisions"])
        self.assertEqual(
            [r["kind"] for r in cell["tokens"][0]["revisions"]], ["del", "ins"]
        )
        self.assertIn("/del/1/tbl/1/tr/1/tc/1/p/1", cell["context"]["xml_path"])
        self.assertEqual(outer["text"], "OuterResult")
        self.assertEqual(outer["all_text"], "OuterCODEResult")
        self.assertEqual(inner["text"], "Textbox")
        self.assertEqual(inner["tokens"][0]["fields"], [])
        self.assertIn("/txbxContent/1/p/1", inner["context"]["xml_path"])
        self.assertEqual(
            list(report["records"]),
            [f"word/document.xml/paragraph/{i}" for i in range(1, 5)],
        )

    def test_field_state_does_not_leak_between_parts_or_notes(self):
        report = self.inspect(
            '<w:p><w:r><w:fldChar w:fldCharType="begin"/>'
            "<w:instrText>unfinished</w:instrText></w:r></w:p>",
            {
                "word/_rels/document.xml.rels": relationships(
                    ("notes", "footnotes", "footnotes.xml"),
                    ("header", "header", "header1.xml"),
                ),
                "word/footnotes.xml": (
                    f'<w:footnotes xmlns:w="{WORD}"><w:footnote w:id="1">'
                    '<w:p><w:r><w:fldChar w:fldCharType="begin"/></w:r></w:p>'
                    '</w:footnote><w:footnote w:id="2"><w:p><w:r><w:t>Note</w:t>'
                    "</w:r></w:p></w:footnote></w:footnotes>"
                ),
                "word/header1.xml": (
                    f'<w:hdr xmlns:w="{WORD}"><w:p><w:r><w:t>Header</w:t>'
                    "</w:r></w:p></w:hdr>"
                ),
            },
        )
        self.assertEqual(
            self.paragraphs(report, "word/footnotes.xml")[1]["text"], "Note"
        )
        self.assertEqual(
            self.paragraphs(report, "word/header1.xml")[0]["text"], "Header"
        )
        self.assertEqual(
            sum("no end at story boundary" in w for w in report["warnings"]), 2
        )

    def test_malformed_field_warnings_retain_locations_and_text(self):
        report = self.inspect(
            '<w:p><w:r><w:fldChar w:fldCharType="separate"/><w:t>Visible</w:t>'
            '<w:fldChar w:fldCharType="end"/><w:instrText>orphan code</w:instrText>'
            '<w:fldChar w:fldCharType="begin"/><w:delInstrText>deleted code</w:delInstrText>'
            '<w:fldChar w:fldCharType="separate"/>'
            '<w:fldChar w:fldCharType="separate"/><w:fldChar w:fldCharType="unknown"/>'
            "<w:t>Cached</w:t></w:r></w:p>"
        )
        paragraph = self.paragraphs(report)[0]
        self.assertEqual(paragraph["text"], "VisibleCached")
        self.assertEqual(paragraph["field_instructions"], "orphan codedeleted code")
        for message in (
            "separate without begin",
            "end without begin",
            "repeated separate",
            "unknown fldCharType",
            "no end at story boundary",
        ):
            warning = next(w for w in report["warnings"] if message in w)
            self.assertIn(
                "word/document.xml/document/1/body/1/p/1/r/1/fldChar/", warning
            )

    def test_deleted_field_markers_do_not_change_current_display_state(self):
        for kind in ("del", "moveFrom"):
            with self.subTest(kind=kind):
                report = self.inspect(
                    f'<w:p><w:{kind} w:id="9" w:author="Reviewer">'
                    '<w:r><w:fldChar w:fldCharType="begin"/>'
                    f"<w:delInstrText>OLD</w:delInstrText></w:r></w:{kind}></w:p>"
                    "<w:p><w:r><w:t>Ordinary</w:t>"
                    '<w:fldChar w:fldCharType="begin"/><w:instrText>CODE</w:instrText>'
                    f'</w:r><w:{kind} w:id="10"><w:r>'
                    '<w:fldChar w:fldCharType="separate"/>'
                    f"</w:r></w:{kind}><w:r><w:t>still instruction</w:t>"
                    '<w:fldChar w:fldCharType="separate"/></w:r>'
                    f'<w:{kind} w:id="11"><w:r><w:fldChar w:fldCharType="end"/>'
                    f"</w:r></w:{kind}><w:r><w:t>Result</w:t>"
                    '<w:fldChar w:fldCharType="end"/><w:t>After</w:t></w:r></w:p>'
                )
                deleted, current = self.paragraphs(report)
                self.assertEqual(deleted["all_text"], "OLD")
                self.assertEqual(current["text"], "OrdinaryResultAfter")
                self.assertEqual(current["field_instructions"], "CODEstill instruction")
                markers = [
                    token
                    for paragraph in (deleted, current)
                    for token in paragraph["tokens"]
                    if token["kind"] == "fldChar" and token["revisions"]
                ]
                self.assertEqual(len(markers), 3)
                for token in markers:
                    self.assertFalse(token["field_state_applied"])
                    self.assertEqual(token["revisions"][0]["kind"], kind)
                self.assertFalse(any("Word field " in w for w in report["warnings"]))
                self.assertIn("do not change state", " ".join(report["warnings"]))

    def test_field_depth_and_cumulative_snapshot_budgets(self):
        cases = (
            (
                "MAX_XML_DEPTH",
                2,
                3,
                '<w:fldChar w:fldCharType="begin"/>' * 3,
                "field depth limit",
            ),
            (
                "MAX_XML_DEPTH",
                1,
                2,
                '<w:fldChar w:fldCharType="begin"/><w:fldSimple w:instr="DATE"/>',
                "field depth limit",
            ),
            (
                "MAX_XML_NODES",
                3,
                6,
                '<w:fldChar w:fldCharType="begin"/>' * 3,
                "field snapshot budget",
            ),
            (
                "MAX_XML_NODES",
                2,
                4,
                ('<w:fldChar w:fldCharType="begin"/><w:fldChar w:fldCharType="end"/>')
                * 2,
                "field snapshot budget",
            ),
        )
        for limit, budget, boundary, content, message in cases:
            with self.subTest(limit=limit, budget=budget, content=content):
                data = io.BytesIO()
                with zipfile.ZipFile(data, "w") as archive:
                    archive.writestr(
                        "word/document.xml",
                        f'<w:document xmlns:w="{WORD}"><w:body><w:p><w:r>'
                        f"{content}</w:r></w:p></w:body></w:document>",
                    )
                # Parse under normal XML limits, then isolate the extraction budgets.
                package = office_inspect.Package(data.getvalue())
                self.addCleanup(package.archive.close)
                # The exact boundary is allowed; the reduced budget must reject it.
                with patch.object(office_inspect, limit, boundary):
                    office_inspect.extract_docx(package, {}, [])
                with patch.object(office_inspect, limit, budget):
                    with self.assertRaisesRegex(
                        office_inspect.InspectionError, message
                    ):
                        office_inspect.extract_docx(package, {}, [])


if __name__ == "__main__":
    unittest.main()
