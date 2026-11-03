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
`--format markdown` emits readable tables for sources, detected coverage, records or old/new values, moves, package changes and limitations.
Document-controlled punctuation is emitted as numeric HTML entities to prevent source HTML, links, fences or table delimiters from becoming active Markdown.
Keep JSON as the complete machine-readable evidence; Markdown is a review view, not a schema serialisation.
`--output` exclusively creates a new UTF-8 file; its parent directory must already exist.
Existing output files are never overwritten, including source aliases and hard links.
Do not use shell redirection to an input path: redirection happens before this tool can protect it.
Exit status is `0` on successful inspection/comparison, even when differences exist, and `2` on invalid arguments, unsupported inputs or processing errors.

## Coverage

| Format | Extracted records | Important limits |
| --- | --- | --- |
| XLSX | Ordered sheets and visibility, stored cells, lexical values, formulas and caches, hidden-row attributes, column/merge/filter/table-reference structures, classic comments | No recalculation, date/style interpretation, shared-formula expansion, full table definitions, threaded comments or drawing text |
| PPTX | Ordered slides, slide visibility, DrawingML paragraphs through nested shapes and table cells, object identity attributes, linked slide notes | No inherited master/layout text, chart/SmartArt interpretation or visual rendering |
| DOCX | Paragraphs in the body and tables; linked headers, footers, footnotes, endnotes and comments; XML table/cell context; revision-wrapper metadata; separate field instructions/results | No layout, pagination, reading-order guarantee, resolved revisions or updated fields; revision property changes and move-range markers not interpreted |
| All | Source filename, size and SHA-256; every non-directory ZIP part's uncompressed size and SHA-256; external relationships | Binary objects and unhandled XML are inventoried, not interpreted |

Only OOXML Transitional `.xlsx`, `.pptx` and `.docx` packages with their conventional main-part paths are supported.
Legacy binary formats, macro-enabled extensions, Strict OOXML and encrypted files are rejected.
No images are extracted or recognised with OCR.
XML safety checks cover all `.xml` and `.rels` members, not just extracted content.
The tool rejects DTDs/entities, duplicate or unsafe ZIP member names, encrypted members and package-root-escaping relationships used by extraction.
Hard limits are 256 MiB source size, 10,000 ZIP entries, 32 MiB per expanded part and 512 MiB total expanded size.
XML parsing additionally limits cumulative elements to 300,000 and nesting depth to 128; serialised JSON is limited to 32 MiB.
Word fields have the same nesting limit and a cumulative 300,000 field-snapshot budget; coverage is limited to 10,000 entries and 300,000 relationship-context memberships.
Markdown escaping is budgeted incrementally and final Markdown is limited to 32 MiB.
Larger files require a separately assessed workflow; do not silently disable limits.
These are safeguards, not a sandbox for deliberately hostile documents; reports can also be large.

Each report includes document-specific `coverage` entries with `feature`, `location`, `part`, `status` and `detail`.
Statuses are `extracted`, `inventoried_only` or `unsupported`.
Detected features include media, charts, SmartArt, embedded objects, threaded/slide comments, inherited slide content, external relationships, missing internal targets and missing formula caches.
Relationships map detected parts to sheets/slides when possible; unlinked parts retain package-part locations.
Layout/master relationships are not followed for slide association, so inherited media can remain at package-level locations.
Coverage is not exhaustive and does not imply that graphics or requirements were visually reviewed.

## Output Contract

Schema version `2` contains `tool`, `source`, `format`, `records`, `parts`, `coverage` and `warnings`.
Version 2 changes Word text semantics and comparison matching; consumers must check the schema version.
`source` identifies the bytes actually inspected, without embedding a machine-specific absolute path.
`records` maps source locations to extracted values.
Excel locations include `sheet/1/cell/A1`; the associated `sheet/1` record supplies the sheet name.
PowerPoint locations start with `slide/1` and retain XML paths for group, shape and table context; notes start with `slide/1/notes`.
Word locations use the package part and paragraph number, such as `word/document.xml/paragraph/1`.
This locates XML paragraphs, not rendered page numbers.
Word paragraph `text` is a stored-display view: inserted/moveTo content is included; deleted/moveFrom content and field instructions are excluded.
This does not accept or resolve revisions.
`all_text` retains extracted deletions and field instructions; `field_instructions` separates instructions; `tokens` preserve roles, revision kind/ID/author/date and field state.
Paragraph/token `context.xml_path` identifies table, row and cell ancestry and avoids counting nested textbox paragraphs twice.
Complex fields retain their state across paragraphs, but independent textboxes, notes and comments have separate field stories.
Fields are not evaluated, and malformed field markers produce warnings.
Deleted/moveFrom field markers are retained as evidence but do not alter the current-display field state.

Comparisons contain `before`, `after`, `identical_bytes`, `changes`, `moves`, `coverage` (before/after), `package_changes` and combined `warnings`.
Each difference has `location`, `kind` (`added`, `removed`, `changed`), `before` and `after`.
Content records and package hashes are compared independently.
ZIP metadata or compression differences can change the source hash without changing any uncompressed part.
Formatting-only changes can change package parts without changing extracted records.
Unique sheet IDs are aligned only when the package part or sheet name also agrees; unique slide IDs require an agreeing package part.
These are conservative identity heuristics for related document versions, not proof of semantic equivalence between unrelated documents.
Unmatched or ambiguous identities produce removed/added records and a warning, never guessed positional matches.
`moves` records before/after root locations; aligned changes also retain `before_location` and `after_location` citations.
Other record locations remain positional: inserted rows, paragraphs or shapes can still cause noisy differences.
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
Fixtures cover revisions, fields, nested textboxes, table/cell paths, missing formula caches, relationship-based coverage, identity ambiguity, reordering and Markdown injection escaping.
They are synthetic OOXML, not application-generated fidelity fixtures; real-application corpus coverage remains outstanding.
Run the same checks on Windows/Git Bash and Linux before claiming both environments tested.
Generated `.venv`, `__pycache__` and Ruff caches must not be added to chezmoi.

## Skill Evaluation

Positive prompts: "Compare these two requirement workbooks", "Extract PPTX slide text and notes", "Read this DOCX including its headers".
Negative prompts: "Create a quarterly workbook", "Approve the visual layout of this presentation", "Read this CSV/PDF".
Edge cases: an encrypted workbook must fail clearly; a presentation whose requirements are in screenshots must be reported as only partially inspected; a missing authoritative version must lead to clarification rather than an invented comparison.
These examples define routing expectations, not proof of model-trigger accuracy.
