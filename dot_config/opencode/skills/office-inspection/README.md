# Office Inspection

Read-only inspection and comparison of existing XLSX, PPTX and DOCX files.
The Python implementation is shared by Windows and Linux; Bash is used only for invocation and checks.
No PowerShell files, COM, Microsoft Office or external conversion services are used.

## Requirements

- `uv`, with Python 3.12 or newer available through it.
- Bash: Git Bash on Windows, Bash on Linux.
- Package downloads during initial setup; cached dependencies allow subsequent local processing.

This is original local code, not an imported third-party skill.
Runtime XML parsing uses `defusedxml` (PSF licence); development tools are Ruff (MIT) and ty (MIT).
Exact resolved versions are recorded in `uv.lock`.
OpenCode permissions still apply; the skill does not grant filesystem access or permission to write reports.

## Usage

Run these commands in Bash, from any working directory.
Use forward-slash Windows paths such as `C:/Users/name/project/input.xlsx` for Python arguments under Git Bash, or absolute Linux paths.
Quote paths containing spaces.

```bash
skill="$HOME/.config/opencode/skills/office-inspection"
uv run --project "$skill" --locked python "$skill/scripts/office_inspect.py" inspect "/path/to/input.xlsx"
uv run --project "$skill" --locked python "$skill/scripts/office_inspect.py" inspect "/path/to/input.pptx" --format markdown --output "/path/to/new-report.md"
uv run --project "$skill" --locked python "$skill/scripts/office_inspect.py" compare "/path/to/old.xlsx" "/path/to/new.xlsx" --output "/path/to/new-comparison.json"
```

Default output is UTF-8 JSON on stdout.
`--format markdown` emits limitations and a fenced, indented JSON report, retaining all evidence rather than producing a lossy prose summary.
`--output` exclusively creates a new UTF-8 file; its parent directory must already exist.
Existing output files are never overwritten, including source aliases and hard links.
Do not use shell redirection to an input path: redirection happens before this tool can protect it.
Exit status is `0` on successful inspection/comparison, even when differences exist, and `2` on invalid arguments, unsupported inputs or processing errors.

## Coverage

| Format | Extracted records | Important limits |
| --- | --- | --- |
| XLSX | Ordered sheets and visibility, stored cells, lexical values, formulas and caches, hidden-row attributes, column/merge/filter/table-reference structures, classic comments | No recalculation, date/style interpretation, shared-formula expansion, full table definitions, threaded comments or drawing text |
| PPTX | Ordered slides, slide visibility, DrawingML paragraphs through nested shapes and table cells, object identity attributes, linked slide notes | No inherited master/layout text, chart/SmartArt interpretation or visual rendering |
| DOCX | Paragraphs in the body and tables; linked headers, footers, footnotes, endnotes and comments; field/deleted-text tokens | No layout, pagination, reading-order guarantee, resolved revisions or updated fields |
| All | Source filename, size and SHA-256; every non-directory ZIP part's uncompressed size and SHA-256; external relationships | Binary objects and unhandled XML are inventoried, not interpreted |

Only OOXML Transitional `.xlsx`, `.pptx` and `.docx` packages with their conventional main-part paths are supported.
Legacy binary formats, macro-enabled extensions, Strict OOXML and encrypted files are rejected.
No images are extracted or recognised with OCR.
XML safety checks cover all `.xml` and `.rels` members, not just extracted content.
The tool rejects DTDs/entities, duplicate or unsafe ZIP member names, encrypted members and package-root-escaping relationships used by extraction.
Hard limits are 256 MiB source size, 10,000 ZIP entries, 32 MiB per expanded part and 512 MiB total expanded size.
XML parsing additionally limits cumulative elements to 300,000 and nesting depth to 128; serialised JSON is limited to 32 MiB.
Larger files require a separately assessed workflow; do not silently disable limits.
These are safeguards, not a sandbox for deliberately hostile documents; reports can also be large.

## Output Contract

Schema version `1` contains `tool`, `source`, `format`, `records`, `parts` and `warnings`.
`source` identifies the bytes actually inspected, without embedding a machine-specific absolute path.
`records` maps source locations to extracted values.
Excel locations include `sheet/1/cell/A1`; the associated `sheet/1` record supplies the sheet name.
PowerPoint locations start with `slide/1` and retain XML paths for group, shape and table context; notes start with `slide/1/notes`.
Word locations use the package part and paragraph number, such as `word/document.xml/paragraph/1`.
This locates XML paragraphs, not rendered page numbers.

Comparisons contain `before`, `after`, `identical_bytes`, `changes`, `package_changes` and combined `warnings`.
Each difference has `location`, `kind` (`added`, `removed`, `changed`), `before` and `after`.
Content records and package hashes are compared independently.
ZIP metadata or compression differences can change the source hash without changing any uncompressed part.
Formatting-only changes can change package parts without changing extracted records.
Record locations are positional, not a semantic alignment algorithm: insertions and reordering can cause noisy differences.
Missing values are represented by JSON `null`; `kind` distinguishes absence from a stored null value.

## Verification

From the skill directory, the single format-check entry point is:

```bash
bash scripts/check.sh --format-only
```

The full check runs format, lint, type checks and synthetic OOXML tests:

```bash
bash scripts/check.sh
```

Tests create temporary fixtures, never use corporate documents and verify original bytes remain unchanged.
Run the same checks on Windows/Git Bash and Linux before claiming both environments tested.
Generated `.venv`, `__pycache__` and Ruff caches must not be added to chezmoi.

## Skill Evaluation

Positive prompts: "Compare these two requirement workbooks", "Extract PPTX slide text and notes", "Read this DOCX including its headers".
Negative prompts: "Create a quarterly workbook", "Approve the visual layout of this presentation", "Read this CSV/PDF".
Edge cases: an encrypted workbook must fail clearly; a presentation whose requirements are in screenshots must be reported as only partially inspected; a missing authoritative version must lead to clarification rather than an invented comparison.
These examples define routing expectations, not proof of model-trigger accuracy.
