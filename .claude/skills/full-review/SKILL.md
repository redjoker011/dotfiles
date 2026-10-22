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
6. **Summary.** Add `## Summary` after the four headings: one line per heading, giving the finding count and the worst finding under that heading.
7. **Approval Check.** Always end with `## Approval Check`, even when nothing turned up.
   - First line: `Verdict: <Approve | Approve with nits | Request changes>, <N> blockers`.
   - `### Blocks approval`: a finding this diff introduces that breaks something on merge: a `bug:`, or a `risk:` of data loss, a broken migration or deploy, a security hole, or a test the repo requires but lacks. Confirm each against the code first; one you can't confirm goes in the next list, tagged `(unverified)`. Give each as `file:line`, its prefix, one sentence, the heading it came from, and what clears it.
   - `### Raise, doesn't block`: every other `risk:` and `q:`, and any ponytail finding that would change the code. Code moved unchanged or already on the fixed point, stale docs, and risks that only bite in future work land here.
   - Number items in one sequence across both lists, so each number names one finding.
   - The verdict follows from the lists: any blocker is `Request changes`; only non-blocking items is `Approve with nits`; both empty is `Approve`, with `Nothing worth raising.` Leave `nit:`s out of both lists.

## Format

- Severity prefixes are plain text: `bug:`, `risk:`, `nit:`, `q:`. Never use emoji.
- Ponytail tags (`delete:`, `stdlib:`, `native:`, `yagni:`, `shrink:`) stay as written.
- Review only. Do not edit code, post PR comments, or approve. The Approval Check verdict is a recommendation to the user, nothing more.
