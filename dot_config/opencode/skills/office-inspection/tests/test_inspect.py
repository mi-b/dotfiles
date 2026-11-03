import copy
import hashlib
import json
import struct
import subprocess
import sys
import tempfile
import unittest
import warnings
import zipfile
from unittest.mock import patch
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
import office_inspect

REL = "http://schemas.openxmlformats.org/package/2006/relationships"
OFFICE_REL = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
SHEET = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
WORD = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
DRAWING = "http://schemas.openxmlformats.org/drawingml/2006/main"
PRESENTATION = "http://schemas.openxmlformats.org/presentationml/2006/main"


def relationships(*entries):
    return (
        f'<Relationships xmlns="{REL}">'
        + "".join(
            f'<Relationship Id="{ident}" Type="{OFFICE_REL}/{kind}" Target="{target}"/>'
            for ident, kind, target in entries
        )
        + "</Relationships>"
    )


def package_parts(kind):
    main, content_type = {
        "xlsx": ("xl/workbook.xml", "spreadsheetml.sheet"),
        "pptx": ("ppt/presentation.xml", "presentationml.presentation"),
        "docx": ("word/document.xml", "wordprocessingml.document"),
    }[kind]
    return {
        "[Content_Types].xml": (
            '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
            '<Default Extension="xml" ContentType="application/xml"/>'
            '<Default Extension="rels" '
            'ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
            f'<Override PartName="/{main}" '
            f'ContentType="application/vnd.openxmlformats-officedocument.{content_type}.main+xml"/>'
            "</Types>"
        ),
        "_rels/.rels": relationships(("rId1", "officeDocument", main)),
    }


def spreadsheet():
    return package_parts("xlsx") | {
        "xl/workbook.xml": (
            f'<workbook xmlns="{SHEET}" xmlns:r="{OFFICE_REL}"><sheets>'
            '<sheet name="Hidden data" sheetId="1" state="hidden" r:id="rId1"/>'
            "</sheets></workbook>"
        ),
        "xl/_rels/workbook.xml.rels": relationships(
            ("rId1", "worksheet", "worksheets/sheet1.xml"),
            ("rId2", "sharedStrings", "sharedStrings.xml"),
        ),
        "xl/worksheets/sheet1.xml": (
            f'<worksheet xmlns="{SHEET}"><sheetData><row r="1">'
            '<c r="A1"><f>1+1</f><v>2</v></c>'
            '<c r="B1" t="s"><v>0</v></c>'
            "</row></sheetData></worksheet>"
        ),
        "xl/sharedStrings.xml": (
            f'<sst xmlns="{SHEET}" count="1" uniqueCount="1">'
            "<si><t>Shared greeting</t></si></sst>"
        ),
        "xl/worksheets/_rels/sheet1.xml.rels": relationships(
            ("rId1", "comments", "../comments1.xml"),
        ),
        "xl/comments1.xml": (
            f'<comments xmlns="{SHEET}"><authors><author>Reviewer</author></authors>'
            '<commentList><comment ref="B1" authorId="0"><text>'
            "<t>Review comment</t></text></comment></commentList></comments>"
        ),
    }


def document(text="Body paragraph"):
    return package_parts("docx") | {
        "word/document.xml": (
            f'<w:document xmlns:w="{WORD}" xmlns:r="{OFFICE_REL}"><w:body>'
            f"<w:p><w:r><w:t>{text}</w:t></w:r></w:p>"
            "<w:tbl><w:tr><w:tc><w:p><w:r><w:t>Table paragraph</w:t>"
            "</w:r></w:p></w:tc></w:tr></w:tbl>"
            '<w:sectPr><w:headerReference w:type="default" r:id="rId1"/>'
            "</w:sectPr></w:body></w:document>"
        ),
        "word/_rels/document.xml.rels": relationships(
            ("rId1", "header", "header1.xml"),
        ),
        "word/header1.xml": (
            f'<w:hdr xmlns:w="{WORD}"><w:p><w:r><w:t>Header paragraph</w:t>'
            "</w:r></w:p></w:hdr>"
        ),
    }


def presentation():
    return package_parts("pptx") | {
        "ppt/presentation.xml": (
            f'<p:presentation xmlns:p="{PRESENTATION}" xmlns:r="{OFFICE_REL}">'
            '<p:sldIdLst><p:sldId id="256" r:id="rId1"/></p:sldIdLst>'
            "</p:presentation>"
        ),
        "ppt/_rels/presentation.xml.rels": relationships(
            ("rId1", "slide", "slides/slide1.xml"),
        ),
        "ppt/slides/slide1.xml": (
            f'<p:sld xmlns:p="{PRESENTATION}" xmlns:a="{DRAWING}">'
            "<p:cSld><p:spTree><p:grpSp><p:grpSp><p:sp><p:txBody>"
            "<a:bodyPr/><a:lstStyle/><a:p><a:r><a:t>Nested paragraph</a:t>"
            "</a:r></a:p><a:p><a:r><a:t>Second paragraph</a:t></a:r></a:p>"
            "</p:txBody></p:sp></p:grpSp></p:grpSp></p:spTree></p:cSld></p:sld>"
        ),
        "ppt/slides/_rels/slide1.xml.rels": relationships(
            ("rId1", "notesSlide", "../notesSlides/notesSlide1.xml"),
        ),
        "ppt/notesSlides/notesSlide1.xml": (
            f'<p:notes xmlns:p="{PRESENTATION}" xmlns:a="{DRAWING}">'
            "<p:cSld><p:spTree><p:sp><p:txBody><a:bodyPr/><a:lstStyle/>"
            "<a:p><a:r><a:t>Speaker notes</a:t></a:r></a:p>"
            "</p:txBody></p:sp></p:spTree></p:cSld></p:notes>"
        ),
    }


def strings(value):
    if isinstance(value, dict):
        for child in value.values():
            yield from strings(child)
    elif isinstance(value, list):
        for child in value:
            yield from strings(child)
    elif isinstance(value, str):
        yield value


class InspectTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.directory = Path(self.temp.name)

    def write_package(self, name, parts):
        path = self.directory / name
        with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as archive:
            for member, content in parts.items():
                archive.writestr(member, content)
        return path

    def cli(self, *args):
        return subprocess.run(
            ["uv", "run", "scripts/office_inspect.py", *map(str, args)],
            check=False,
            cwd=ROOT,
            capture_output=True,
            encoding="utf-8",
            errors="strict",
            timeout=60,
        )

    def assert_report(self, path, kind):
        original = path.read_bytes()
        report = office_inspect.inspect_file(path)
        self.assertEqual(report["schema_version"], 2)
        self.assertEqual(report["format"], kind)
        self.assertEqual(report["source"]["name"], path.name)
        self.assertEqual(
            report["source"]["sha256"], hashlib.sha256(original).hexdigest()
        )
        self.assertEqual(report["source"]["size_bytes"], len(original))
        self.assertIsInstance(report["records"], dict)
        self.assertIsInstance(report["warnings"], list)
        self.assertTrue(all(isinstance(item, str) for item in report["warnings"]))
        with zipfile.ZipFile(path) as archive:
            expected = {
                name: (
                    hashlib.sha256(archive.read(name)).hexdigest(),
                    len(archive.read(name)),
                )
                for name in archive.namelist()
            }
        self.assertIsInstance(report["parts"], list)
        self.assertEqual(len(report["parts"]), len(expected))
        self.assertEqual(
            {
                part["name"]: (part["sha256"], part["size_bytes"])
                for part in report["parts"]
            },
            expected,
        )
        json.dumps(report, allow_nan=False)
        self.assertEqual(path.read_bytes(), original)
        return report

    def test_spreadsheet_values_formula_hidden_sheet_and_comment(self):
        path = self.write_package("book.xlsx", spreadsheet())
        report = self.assert_report(path, "xlsx")
        sheet = report["records"]["sheet/1"]
        self.assertEqual(sheet["name"], "Hidden data")
        self.assertEqual(sheet["state"], "hidden")
        cell = report["records"]["sheet/1/cell/A1"]
        self.assertIn("value", cell)
        self.assertEqual(cell["formula"], "1+1")
        self.assertIn(cell["cached_value"], (2, "2"))
        text = " ".join(strings(report["records"]))
        for expected in ("Shared greeting", "Review comment"):
            self.assertIn(expected, text)

    def test_presentation_nested_paragraphs_and_notes(self):
        path = self.write_package("slides.pptx", presentation())
        report = self.assert_report(path, "pptx")
        text = " ".join(strings(report["records"]))
        for expected in ("Nested paragraph", "Second paragraph", "Speaker notes"):
            self.assertIn(expected, text)

    def test_document_body_table_and_header(self):
        path = self.write_package("document.docx", document())
        report = self.assert_report(path, "docx")
        text = " ".join(strings(report["records"]))
        for expected in ("Body paragraph", "Table paragraph", "Header paragraph"):
            self.assertIn(expected, text)

    def test_compare_self_and_record_change_kinds(self):
        path = self.write_package("document.docx", document())
        before = office_inspect.inspect_file(path)
        same = office_inspect.compare_reports(before, before)
        self.assertIs(same["identical_bytes"], True)
        self.assertEqual(same["changes"], [])
        self.assertEqual(same["package_changes"], [])
        before = copy.deepcopy(before)
        before["records"] = {"keep": "same", "edit": "old", "remove": "gone"}
        after = copy.deepcopy(before)
        after["records"] = {"keep": "same", "edit": "new", "add": "here"}
        result = office_inspect.compare_reports(before, after)
        self.assertEqual(
            {
                item["location"]: (item["before"], item["after"], item["kind"])
                for item in result["changes"]
            },
            {
                "edit": ("old", "new", "changed"),
                "remove": ("gone", None, "removed"),
                "add": (None, "here", "added"),
            },
        )

    def test_raw_part_change_without_text_change(self):
        parts = document()
        old = self.write_package("old.docx", parts)
        parts["word/document.xml"] = "\n" + parts["word/document.xml"]
        new = self.write_package("new.docx", parts)
        before = office_inspect.inspect_file(old)
        after = office_inspect.inspect_file(new)
        self.assertEqual(before["records"], after["records"])
        result = office_inspect.compare_reports(before, after)
        self.assertIs(result["identical_bytes"], False)
        self.assertEqual(result["changes"], [])
        self.assertTrue(result["package_changes"])

    def test_invalid_inputs_exit_two(self):
        malformed = self.directory / "malformed.docx"
        malformed.write_bytes(b"not a ZIP")
        legacy = self.directory / "legacy.doc"
        legacy.write_bytes(b"legacy document")
        dtd = document()
        dtd["word/document.xml"] = (
            '<!DOCTYPE document [<!ENTITY injected "unsafe">]>'
            + dtd["word/document.xml"]
        )
        traversal = document() | {"../outside.xml": "<outside/>"}
        duplicate = self.write_package("duplicate.docx", document())
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            with zipfile.ZipFile(duplicate, "a") as archive:
                archive.writestr("word/document.xml", document()["word/document.xml"])
        encrypted = self.write_package("encrypted.docx", document())
        data = bytearray(encrypted.read_bytes())
        # Set the encryption flag in both local and central directory headers.
        with zipfile.ZipFile(encrypted) as archive:
            for info in archive.infolist():
                struct.pack_into("<H", data, info.header_offset + 6, info.flag_bits | 1)
            position = archive.start_dir
        while data[position : position + 4] == b"PK\x01\x02":
            flags = struct.unpack_from("<H", data, position + 8)[0]
            struct.pack_into("<H", data, position + 8, flags | 1)
            lengths = struct.unpack_from("<HHH", data, position + 28)
            position += 46 + sum(lengths)
        encrypted.write_bytes(data)
        paths = [
            malformed,
            legacy,
            duplicate,
            encrypted,
            self.directory / "missing.docx",
            self.write_package("dtd.docx", dtd),
            self.write_package("traversal.docx", traversal),
        ]
        for path in paths:
            with self.subTest(path=path.name):
                result = self.cli("inspect", path, "--format", "json")
                self.assertEqual(result.returncode, 2, result.stdout + result.stderr)

    def test_cli_json_stdout_and_output_formats(self):
        text = "Gr\u00fcsse aus Z\u00fcrich"
        path = self.write_package("unicode.docx", document(text))
        result = self.cli("inspect", path, "--format", "json")
        self.assertEqual(result.returncode, 0, result.stderr)
        report = json.loads(result.stdout)
        self.assertIn(text, " ".join(strings(report["records"])))
        for command in (("inspect", path), ("compare", path, path)):
            for output_format in ("json", "markdown"):
                with self.subTest(command=command[0], format=output_format):
                    output = self.directory / f"{command[0]}.{output_format}"
                    result = self.cli(
                        *command, "--output", output, "--format", output_format
                    )
                    self.assertEqual(result.returncode, 0, result.stderr)
                    content = output.read_text(encoding="utf-8")
                    self.assertTrue(content.strip())
                    if output_format == "json":
                        json.loads(content)
        other = self.write_package("changed.docx", document("Changed body"))
        result = self.cli("compare", path, other, "--format", "json")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(json.loads(result.stdout)["changes"])

    def test_cli_output_cannot_overwrite_either_input(self):
        old = self.write_package("old.docx", document())
        new = self.write_package("new.docx", document("Changed body"))
        originals = {path: path.read_bytes() for path in (old, new)}
        for command, output in [
            (("inspect", old), old),
            (("compare", old, new), old),
            (("compare", old, new), new),
        ]:
            with self.subTest(command=command[0], output=output.name):
                result = self.cli(*command, "--output", output, "--format", "json")
                self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
                for path, content in originals.items():
                    self.assertEqual(path.read_bytes(), content)

    def test_resource_limits(self):
        path = self.write_package("limits.docx", document())
        with patch.object(office_inspect, "MAX_XML_NODES", 5):
            with self.assertRaisesRegex(office_inspect.InspectionError, "node/depth"):
                office_inspect.inspect_file(path)
        with patch.object(office_inspect, "MAX_XML_DEPTH", 2):
            with self.assertRaisesRegex(office_inspect.InspectionError, "node/depth"):
                office_inspect.inspect_file(path)
        with patch.object(office_inspect, "MAX_OUTPUT", 100):
            with self.assertRaisesRegex(office_inspect.InspectionError, "output limit"):
                office_inspect.serialise({"cells": ["long shared string" * 10] * 100})

    def test_phonetic_annotations_excluded_and_arbitrary_root_id(self):
        parts = spreadsheet()
        parts["_rels/.rels"] = relationships(
            ("arbitraryId", "officeDocument", "xl/workbook.xml")
        )
        parts["xl/sharedStrings.xml"] = (
            f'<sst xmlns="{SHEET}"><si><t>Base</t>'
            '<rPh sb="0" eb="4"><t>Pronunciation</t></rPh></si></sst>'
        )
        parts["xl/worksheets/sheet1.xml"] = parts["xl/worksheets/sheet1.xml"].replace(
            "</row>",
            '<c r="C1" t="inlineStr"><is><r><t>Rich</t></r>'
            '<rPh sb="0" eb="4"><t>Pronunciation</t></rPh></is></c></row>',
        )
        report = office_inspect.inspect_file(self.write_package("phonetic.xlsx", parts))
        self.assertEqual(report["records"]["sheet/1/cell/B1"]["value"], "Base")
        self.assertEqual(report["records"]["sheet/1/cell/C1"]["value"], "Rich")


if __name__ == "__main__":
    unittest.main()
