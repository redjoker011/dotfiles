---
name: full-review
description: Use when the user invokes /full-review, or asks for a full, complete, or three-way review of a branch, PR, or the changes since a fixed point.
---

# Full Review

Three independent reviews of one diff. Each covers a lens the others miss:

| Skill | Lens |
|-------|------|
| `mattpocock-skills:code-review` | repo standards + spec match |
| `ponytail:ponytail-review` | over-engineering, what to delete |
| `code-review` (built-in, unscoped) | correctness bugs |

Args: `[fixed-point] [level]`. Fixed point defaults to `main`. Level defaults to `high`.

## Process

1. **Pin the diff.** Run `git rev-parse <fixed-point>`. Run `git diff --stat <fixed-point>...HEAD`. Bad ref or empty diff: stop and tell the user.
2. **Standards + Spec.** Invoke `mattpocock-skills:code-review` with the fixed point. Follow that skill fully, including its spec lookup and its two sub-agents.
3. **Over-engineering.** Invoke `ponytail:ponytail-review` on `git diff <fixed-point>...HEAD`.
4. **Correctness.** Run `gh pr view --json number -q .number`. Invoke the unscoped `code-review` skill with that PR number, or with the current branch name if no PR exists, plus the level. Never pass `--comment` or `--fix`.
5. **Report.** Use four headings in this order: `## Standards`, `## Spec`, `## Over-engineering`, `## Correctness`. Put each skill's findings under its own heading. Do not merge, dedupe, or rerank findings across headings.
6. **Summary.** End with one line per heading: finding count and the worst finding under that heading.

## Format

- Severity prefixes are plain text: `bug:`, `risk:`, `nit:`, `q:`. Never use emoji.
- Ponytail tags (`delete:`, `stdlib:`, `native:`, `yagni:`, `shrink:`) stay as written.
- Review only. Do not edit code, post PR comments, or approve.
