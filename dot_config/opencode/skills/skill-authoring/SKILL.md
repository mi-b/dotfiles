---
name: skill-authoring
description: >
  Use when creating, adapting, reviewing, or updating Agent Skills and SKILL.md
  files. Produces small portable skills, identifies harness and runtime
  dependencies, records provenance, and defines realistic trigger and output
  tests.
compatibility: Agent Skills-compatible harness with file editing tools.
---

# Skill Authoring

Create the smallest skill that reliably adds knowledge or a repeatable workflow.
Do not turn ordinary preferences into skills or import a framework to obtain one useful paragraph.

## Establish The Contract

Before editing, determine:

1. What capability the skill adds beyond the model's normal behaviour.
2. Which user requests should trigger it and which adjacent requests should not.
3. What successful output or behaviour looks like.
4. Which tools, executables, network access, operating systems, or harness features it requires.
5. Whether the result is original, adapted, or an unchanged upstream dependency.

Ask only for information that cannot be inferred from the current task and files.

## Choose The Right Location

- Put personal reusable skills in the user's managed global skill directory.
- Put project-specific knowledge and workflows in the project's skill directory.
- Keep stable preferences that apply to every task in global instructions instead.
- Create a specialised agent only when the role needs distinct context, tools, permissions, or delegation behaviour.

## Structure The Skill

Use one directory whose name matches the frontmatter `name`:

```text
skill-name/
├── SKILL.md
├── references/  # Optional detailed material loaded when needed
├── scripts/     # Optional deterministic or repeated operations
└── assets/      # Optional templates and output resources
```

Keep the main workflow in `SKILL.md` and move non-essential detail into focused reference files.
Mention each bundled resource where the agent should use it.
Avoid chains of references and duplicated guidance.

## Write Effective Metadata

- Use a unique lowercase, hyphen-separated name of at most 64 characters.
- Describe both what the skill does and when it should load.
- Include likely task terms and filenames, but avoid broad keywords that cause false triggers.
- Add `compatibility` only for concrete environment requirements.
- Treat `allowed-tools` as experimental metadata, not as a security boundary.

## Keep Instructions Portable

Describe actions by intent rather than assuming a particular tool name.
When a workflow depends on OpenCode, Claude Code, Codex, or another harness, state that dependency explicitly and isolate harness-specific steps.
Prefer cross-platform operations; otherwise document and test each supported platform.

Permissions belong to the harness configuration.
Never tell a skill to bypass approval, weaken permissions, expose secrets, or execute downloaded code without review.

## Handle Upstream Material

- Pin unchanged third-party skills to an immutable revision when the deployment system supports it.
- Copy and locally maintain a skill once it needs adaptation.
- Preserve licence and attribution requirements.
- Record the source path, starting revision, and nature of local changes.
- Review upstream updates as diffs; never merge them blindly into an adapted skill.

## Test Before Declaring Success

Start with a small evaluation set:

1. Two or three realistic prompts that should load the skill.
2. Two or three near-miss prompts that should not load it.
3. At least one edge case involving missing input, an unsupported environment, or ambiguous intent.

Run output tests with the skill and compare them with either no skill or the previous version.
Check objective requirements programmatically where practical and review subjective quality manually.
Revise instructions that add cost without improving results.

## Completion Checklist

- The directory and frontmatter names match.
- The description states capability and trigger conditions.
- Dependencies and compatibility limits are explicit.
- Scripts and external content have been reviewed.
- Provenance and licensing are recorded where needed.
- Positive, negative, and edge-case prompts have been considered.
- The harness discovers the skill after deployment.
