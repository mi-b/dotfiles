import copy
import hashlib
import html
import unittest
from unittest.mock import patch
from xml.sax.saxutils import escape

import test_inspect as fixtures

office_inspect = fixtures.office_inspect


def ordered_parts(kind, entries):
    """Build ordered sheets/slides from (ID, part basename, name, text)."""
    parts = fixtures.package_parts(kind)
    if kind == "xlsx":
        parts["xl/workbook.xml"] = (
            f'<workbook xmlns="{fixtures.SHEET}" xmlns:r="{fixtures.OFFICE_REL}">'
            "<sheets>"
            + "".join(
                f'<sheet sheetId="{ident}" name="{name}" r:id="rId{index}"/>'
                for index, (ident, _, name, _) in enumerate(entries, 1)
            )
            + "</sheets></workbook>"
        )
        parts["xl/_rels/workbook.xml.rels"] = fixtures.relationships(
            *(
                (f"rId{index}", "worksheet", f"worksheets/{part}.xml")
                for index, (_, part, _, _) in enumerate(entries, 1)
            )
        )
        for _, part, _, text in entries:
            parts[f"xl/worksheets/{part}.xml"] = (
                f'<worksheet xmlns="{fixtures.SHEET}"><sheetData><row r="1">'
                f'<c r="A1" t="inlineStr"><is><t>{escape(text)}</t></is></c>'
                "</row></sheetData></worksheet>"
            )
    else:
        parts["ppt/presentation.xml"] = (
            f'<p:presentation xmlns:p="{fixtures.PRESENTATION}" '
            f'xmlns:r="{fixtures.OFFICE_REL}"><p:sldIdLst>'
            + "".join(
                f'<p:sldId id="{ident}" r:id="rId{index}"/>'
                for index, (ident, _, _, _) in enumerate(entries, 1)
            )
            + "</p:sldIdLst></p:presentation>"
        )
        parts["ppt/_rels/presentation.xml.rels"] = fixtures.relationships(
            *(
                (f"rId{index}", "slide", f"slides/{part}.xml")
                for index, (_, part, _, _) in enumerate(entries, 1)
            )
        )
        for _, part, _, text in entries:
            parts[f"ppt/slides/{part}.xml"] = fixtures.presentation()[
                "ppt/slides/slide1.xml"
            ].replace("Nested paragraph", escape(text))
    return parts


class ReportingTests(unittest.TestCase):
    def setUp(self):
        self.fixture = fixtures.InspectTests()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)

    def write_package(self, name, parts):
        return self.fixture.write_package(name, parts)

    def inspect(self, name, parts):
        return office_inspect.inspect_file(self.write_package(name, parts))

    def compare_entries(self, kind, before, after):
        return office_inspect.compare_reports(
            self.inspect(f"before.{kind}", ordered_parts(kind, before)),
            self.inspect(f"after.{kind}", ordered_parts(kind, after)),
        )

    def test_expanded_report_budgets(self):
        parts = fixtures.spreadsheet()
        parts["xl/worksheets/_rels/sheet1.xml.rels"] = (
            f'<Relationships xmlns="{fixtures.REL}">'
            + "".join(
                f'<Relationship Id="ext{i}" Type="{fixtures.OFFICE_REL}/hyperlink" '
                f'Target="https://example.invalid/{i}" TargetMode="External"/>'
                for i in range(5)
            )
            + "</Relationships>"
        )
        with patch.object(office_inspect, "MAX_COVERAGE", 3):
            with self.assertRaisesRegex(
                office_inspect.InspectionError, "Coverage entry"
            ):
                self.inspect("coverage-limit.xlsx", parts)
        report = self.inspect("markdown-limit.docx", fixtures.document("!" * 4000))
        encoded = office_inspect.serialise(report)
        with patch.object(
            office_inspect, "MAX_OUTPUT", len(encoded.encode("utf-8")) + 100
        ):
            with self.assertRaisesRegex(
                office_inspect.InspectionError, "Markdown escaping"
            ):
                office_inspect.markdown(report)

    def test_spreadsheet_coverage_features_follow_drawing_relationships(self):
        parts = fixtures.spreadsheet()
        parts["xl/worksheets/_rels/sheet1.xml.rels"] = fixtures.relationships(
            ("drawing", "drawing", "../drawings/drawing1.xml"),
            ("thread", "threadedComment", "../threadedComments/threadedComment1.xml"),
        )
        parts["xl/drawings/drawing1.xml"] = "<drawing/>"
        parts["xl/drawings/_rels/drawing1.xml.rels"] = fixtures.relationships(
            ("chart", "chart", "../charts/chart1.xml"),
            ("image", "image", "../media/image1.png"),
            ("object", "oleObject", "../embeddings/object1.bin"),
        )
        parts.update(
            {
                "xl/charts/chart1.xml": "<chart><text>Chart secret</text></chart>",
                "xl/media/image1.png": b"synthetic image bytes",
                "xl/embeddings/object1.bin": b"synthetic embedded bytes",
                "xl/threadedComments/threadedComment1.xml": (
                    "<threadedComments><text>Thread secret</text></threadedComments>"
                ),
                "xl/media/orphan.png": b"unlinked image",
            }
        )
        report = self.inspect("coverage.xlsx", parts)
        expected = {
            "xl/charts/chart1.xml": ("chart", "inventoried_only", "sheet/1"),
            "xl/media/image1.png": ("image_or_media", "inventoried_only", "sheet/1"),
            "xl/embeddings/object1.bin": (
                "embedded_object",
                "inventoried_only",
                "sheet/1",
            ),
            "xl/threadedComments/threadedComment1.xml": (
                "threaded_comments",
                "unsupported",
                "sheet/1",
            ),
            "xl/media/orphan.png": (
                "image_or_media",
                "inventoried_only",
                "xl/media/orphan.png",
            ),
        }
        for part, (feature, status, location) in expected.items():
            with self.subTest(part=part):
                entries = [item for item in report["coverage"] if item["part"] == part]
                self.assertEqual(len(entries), 1)
                self.assertEqual(
                    (
                        entries[0]["feature"],
                        entries[0]["status"],
                        entries[0]["location"],
                    ),
                    (feature, status, location),
                )
                content = parts[part]
                data = content.encode() if isinstance(content, str) else content
                inventory = next(
                    item for item in report["parts"] if item["name"] == part
                )
                self.assertEqual(inventory["sha256"], hashlib.sha256(data).hexdigest())
                self.assertEqual(inventory["size_bytes"], len(data))
        extracted = " ".join(fixtures.strings(report["records"]))
        self.assertNotIn("Chart secret", extracted)
        self.assertNotIn("Thread secret", extracted)

    def test_slide_coverage_propagates_shared_media_without_layout_backlinks(self):
        parts = ordered_parts(
            "pptx", [("256", "slide1", "", "First"), ("257", "slide2", "", "Second")]
        )
        parts["ppt/slides/_rels/slide1.xml.rels"] = fixtures.relationships(
            ("drawing", "drawing", "../drawings/drawing1.xml"),
            ("layout", "slideLayout", "../slideLayouts/slideLayout1.xml"),
            ("notes", "notesSlide", "../notesSlides/notesSlide1.xml"),
        )
        parts["ppt/slides/_rels/slide2.xml.rels"] = fixtures.relationships(
            ("shared", "image", "../media/shared.png"),
            ("layout", "slideLayout", "../slideLayouts/slideLayout1.xml"),
        )
        parts["ppt/drawings/drawing1.xml"] = "<drawing/>"
        parts["ppt/drawings/_rels/drawing1.xml.rels"] = fixtures.relationships(
            ("shared", "image", "../media/shared.png"),
            ("chart", "chart", "../charts/chart1.xml"),
        )
        parts["ppt/notesSlides/notesSlide1.xml"] = fixtures.presentation()[
            "ppt/notesSlides/notesSlide1.xml"
        ]
        parts["ppt/notesSlides/_rels/notesSlide1.xml.rels"] = fixtures.relationships(
            ("back", "slide", "../slides/slide2.xml"),
            ("image", "image", "../media/notes.png"),
        )
        parts["ppt/slideLayouts/slideLayout1.xml"] = "<layout/>"
        parts["ppt/slideLayouts/_rels/slideLayout1.xml.rels"] = fixtures.relationships(
            ("image", "image", "../media/layout.png"),
        )
        parts.update(
            {
                "ppt/charts/chart1.xml": "<chart/>",
                "ppt/media/shared.png": b"shared",
                "ppt/media/notes.png": b"notes",
                "ppt/media/layout.png": b"layout",
            }
        )
        report = self.inspect("coverage.pptx", parts)
        for part, locations in {
            "ppt/media/shared.png": {"slide/1", "slide/2"},
            "ppt/charts/chart1.xml": {"slide/1"},
            "ppt/media/notes.png": {"slide/1"},
            "ppt/media/layout.png": {"ppt/media/layout.png"},
        }.items():
            with self.subTest(part=part):
                entries = [item for item in report["coverage"] if item["part"] == part]
                self.assertEqual({item["location"] for item in entries}, locations)
                self.assertEqual(len(entries), len(locations))

    def test_formula_without_stored_value_is_unsupported(self):
        for cached_xml in ("", "<v/>", "<v></v>", "<v>2</v>"):
            with self.subTest(cache=cached_xml):
                parts = fixtures.spreadsheet()
                parts["xl/worksheets/sheet1.xml"] = parts[
                    "xl/worksheets/sheet1.xml"
                ].replace("<f>1+1</f><v>2</v>", f"<f>1+1</f>{cached_xml}")
                report = self.inspect("formula.xlsx", parts)
                missing = [
                    item
                    for item in report["coverage"]
                    if item["feature"] == "missing_formula_cache"
                ]
                if cached_xml == "<v>2</v>":
                    self.assertEqual(missing, [])
                else:
                    self.assertEqual(len(missing), 1)
                    self.assertEqual(missing[0]["location"], "sheet/1/cell/A1")
                    self.assertEqual(missing[0]["status"], "unsupported")
                    self.assertEqual(missing[0]["part"], "xl/worksheets/sheet1.xml")

    def test_reorder_reports_moves_separately_from_content(self):
        entries = [("256", "one", "One", "First"), ("257", "two", "Two", "Second")]
        for kind, prefix in (("xlsx", "sheet"), ("pptx", "slide")):
            with self.subTest(kind=kind):
                result = self.compare_entries(kind, entries, entries[::-1])
                self.assertEqual(result["changes"], [])
                self.assertEqual(
                    {
                        (move["before_location"], move["after_location"], move["id"])
                        for move in result["moves"]
                    },
                    {
                        (f"{prefix}/1", f"{prefix}/2", "256"),
                        (f"{prefix}/2", f"{prefix}/1", "257"),
                    },
                )
                self.assertTrue(result["package_changes"])

    def test_insertion_does_not_positionally_change_existing_content(self):
        entries = [("256", "one", "One", "First"), ("257", "two", "Two", "Second")]
        inserted = ("258", "new", "New", "Inserted")
        for kind, prefix in (("xlsx", "sheet"), ("pptx", "slide")):
            with self.subTest(kind=kind):
                result = self.compare_entries(kind, entries, [inserted, *entries])
                self.assertTrue(result["changes"])
                self.assertTrue(
                    all(item["kind"] == "added" for item in result["changes"])
                )
                self.assertTrue(
                    all(
                        item["before_location"] is None
                        and item["after_location"].startswith(f"{prefix}/1")
                        for item in result["changes"]
                    )
                )
                self.assertEqual(len(result["moves"]), 2)

    def test_sheet_identity_accepts_same_part_or_same_name(self):
        before = [("1", "one", "Original", "Text")]
        for after in (
            [("1", "one", "Renamed", "Text")],
            [("1", "renumbered", "Original", "Text")],
        ):
            with self.subTest(after=after):
                result = self.compare_entries("xlsx", before, after)
                self.assertEqual(len(result["changes"]), 1)
                self.assertEqual(result["changes"][0]["kind"], "changed")
                self.assertEqual(result["changes"][0]["location"], "sheet/1")
                self.assertEqual(result["moves"], [])

    def test_uncorroborated_or_ambiguous_ids_are_removed_and_added(self):
        for kind in ("xlsx", "pptx"):
            cases = [
                ([("1", "one", "One", "Text")], [("1", "other", "Other", "Text")]),
                ([("1", "one", "One", "Text")], [("2", "one", "One", "Text")]),
                ([("", "one", "One", "Text")], [("", "one", "One", "Text")]),
                (
                    [("1", "one", "One", "Text"), ("1", "two", "Two", "Other")],
                    [("1", "one", "One", "Text")],
                ),
                (
                    [("1", "one", "One", "Text")],
                    [("1", "one", "One", "Text"), ("1", "two", "Two", "Other")],
                ),
            ]
            for before, after in cases:
                with self.subTest(kind=kind, before=before, after=after):
                    result = self.compare_entries(kind, before, after)
                    self.assertEqual(result["moves"], [])
                    self.assertEqual(
                        {item["kind"] for item in result["changes"]},
                        {"removed", "added"},
                    )
                    self.assertTrue(
                        any("ambiguous" in warning for warning in result["warnings"])
                    )
                    for item in result["changes"]:
                        if item["kind"] == "removed":
                            self.assertIsNotNone(item["before_location"])
                            self.assertIsNone(item["after_location"])
                        else:
                            self.assertIsNone(item["before_location"])
                            self.assertIsNotNone(item["after_location"])

    def test_changed_content_after_move_has_both_source_citations(self):
        entries = [("256", "one", "One", "First"), ("257", "two", "Two", "Second")]
        after = [entries[1], ("256", "one", "One", "Changed")]
        for kind, prefix in (("xlsx", "sheet"), ("pptx", "slide")):
            with self.subTest(kind=kind):
                result = self.compare_entries(kind, entries, after)
                self.assertEqual(len(result["moves"]), 2)
                self.assertEqual(len(result["changes"]), 1)
                change = result["changes"][0]
                self.assertEqual(change["kind"], "changed")
                self.assertTrue(change["before_location"].startswith(f"{prefix}/1/"))
                self.assertEqual(
                    change["after_location"],
                    change["before_location"].replace(
                        f"{prefix}/1/", f"{prefix}/2/", 1
                    ),
                )
                self.assertEqual(change["location"], change["after_location"])
                self.assertIn("First", fixtures.strings(change["before"]))
                self.assertIn("Changed", fixtures.strings(change["after"]))
                rendered = html.unescape(office_inspect.markdown(result))
                self.assertIn(change["before_location"], rendered)
                self.assertIn(change["after_location"], rendered)

    def assert_safe_markdown(self, report, headings, payload):
        rendered = office_inspect.markdown(report)
        for heading in headings:
            self.assertIn(f"\n{heading}\n", "\n" + rendered)
        self.assertNotIn("<script", rendered)
        self.assertNotIn("<img", rendered)
        self.assertNotIn("`", rendered)
        self.assertNotIn("\r", rendered)
        self.assertNotIn(payload, rendered)
        self.assertIn(payload, html.unescape(rendered))
        expected_pipes = None
        for line in rendered.splitlines():
            if line.startswith("| "):
                if expected_pipes is None:
                    expected_pipes = line.count("|")
                self.assertEqual(line.count("|"), expected_pipes, line)
            else:
                expected_pipes = None
        return rendered

    def test_inspection_markdown_escapes_untrusted_fields_and_retains_hashes(self):
        payload = '<script>alert("x")</script>`|\n## Forged\r\n<img src=x>'
        report = self.inspect("safe.docx", fixtures.document(escape(payload)))
        report["source"]["name"] = payload
        report["records"][payload] = {"text": payload}
        report["warnings"].append(payload)
        for entry in report["coverage"]:
            entry.update(
                location=payload,
                feature=payload,
                status=payload,
                part=payload,
                detail=payload,
            )
        report["parts"][0]["name"] = payload
        rendered = self.assert_safe_markdown(
            report,
            [
                "# Office Inspection",
                "## Sources",
                "## Coverage",
                "### Source",
                "## Extracted Records",
                "## Package Inventory",
                "## Limitations",
            ],
            payload,
        )
        self.assertNotIn("\n## Forged", rendered)
        self.assertIn(report["source"]["sha256"], rendered)
        for part in report["parts"]:
            self.assertIn(part["sha256"], rendered)

    def test_comparison_markdown_escapes_changes_moves_and_package_evidence(self):
        payload = "<img src=x onerror=alert(1)>`|\n# Forged"
        before = self.inspect("before.docx", fixtures.document("Old"))
        after = self.inspect("after.docx", fixtures.document("New"))
        result = office_inspect.compare_reports(before, after)
        result["before"]["name"] = payload
        result["after"]["name"] = payload
        result["warnings"].append(payload)
        result["changes"] = [
            {
                "kind": "changed",
                "location": payload,
                "before_location": payload,
                "after_location": payload,
                "before": payload,
                "after": payload,
            }
        ]
        result["moves"] = [
            {
                "before_location": payload,
                "after_location": payload,
                "id": payload,
                "basis": payload,
            }
        ]
        result["package_changes"] = [
            {
                "kind": "changed",
                "location": payload,
                "before": copy.deepcopy(before["parts"][0]),
                "after": copy.deepcopy(after["parts"][0]),
            }
        ]
        rendered = self.assert_safe_markdown(
            result,
            [
                "## Sources",
                "## Coverage",
                "### Before",
                "### After",
                "## Differences",
                "## Moves",
                "## Package Changes",
                "## Limitations",
            ],
            payload,
        )
        self.assertNotIn("\n# Forged", rendered)
        for source in (before["source"], after["source"]):
            self.assertIn(source["sha256"], rendered)
        for side in ("before", "after"):
            self.assertIn(result["package_changes"][0][side]["sha256"], rendered)


if __name__ == "__main__":
    unittest.main()
