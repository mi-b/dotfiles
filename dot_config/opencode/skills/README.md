# Skills

This directory contains the small, curated set of skills available to OpenCode.
Chezmoi is the source of truth and distributes the skills across machines.

## Management

- Keep original and adapted skills directly in this repository.
- Treat an adapted upstream skill as locally maintained after the first change.
- Record its source and starting revision in the catalogue below.
- Use a commit-pinned chezmoi external only when an upstream skill remains unchanged.
- Never edit generated files under `~/.config/opencode`; edit the chezmoi source instead.
- Keep one active implementation for each skill name.
- Review scripts, dependencies, network access, and licences before importing a skill.

OpenCode permissions remain in `opencode.jsonc` or the relevant agent definition.
A skill may document required capabilities, but it does not grant them.

## Catalogue

| Skill                  | Ownership    | Source                                                                                                                                                       |
|------------------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `handbook-style`       | Local        | Original                                                                                                                                                     |
| `skill-authoring`      | Local        | Original synthesis informed by the Agent Skills specification and the Anthropic, jwiegley, and Superpowers authoring guides                                 |
| `systematic-debugging` | Local adaptation | Adapted from `obra/superpowers/skills/systematic-debugging` at `2ce8aa15d05bd57213e6f746f953aafb7ded7a8b` (MIT); locally maintained without framework dependencies |

## Adding a Skill

1. Check that the capability is distinct from existing global instructions and skills.
2. Prefer adapting useful ideas into a small local skill over importing an entire framework.
3. Use a unique lowercase, hyphen-separated name matching the directory name.
4. Include both the capability and its trigger conditions in the frontmatter description.
5. Test realistic prompts that should and should not load the skill.
6. Apply with chezmoi and verify discovery with `opencode debug skill`.

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [Anthropic skill creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator)
- [jwiegley skill creator](https://github.com/jwiegley/claude-prompts/tree/main/skills/skill-creator)
- [Superpowers writing skills](https://github.com/obra/superpowers/tree/main/skills/writing-skills)
