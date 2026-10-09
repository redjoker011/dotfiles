# Workflow: Spec to Final Review

Personal, repo-independent workflow for Claude Code with the superpowers, mattpocock-skills, and ponytail plugins. Adopted 2026-10-09.

Each repo supplies its own values in `docs/agents/workflow.md` (kept out of git via `.git/info/exclude`), pointed to from its `CLAUDE.md` or `CLAUDE.local.md`. Everything below refers to those values by `{name}`. Where a repo's own documented conventions differ from the defaults here, the repo wins: record the difference in its settings file. The always-on rules are summarized in `~/.claude/CLAUDE.md`; this file is the full reference.

Pick the path first. If unsure, take the heavier one; brainstorming only upgrades a path mid-task, never downgrades.

## Project settings

Each repo's `docs/agents/workflow.md` fills in this table (copy it from here when setting up a new repo).

| Setting | Meaning |
|---------|---------|
| `{base}` | Branch to diff against; for a fork, the upstream branch (fetch first) |
| `{pr-repo}` | Repo that receives PRs |
| `{pr-create}` | Command to open your own PR |
| `{lint}` | Lint gate matching CI |
| `{test}` | Test runner for touched specs/tests |
| `{design-root}` | Where specs and plans live (default `docs/design/`) |
| `{adr-dir}` | ADRs (and their template) |
| `{learnings-dir}` | Gotchas, debugging patterns, integration quirks |
| `{current-docs}` | Maintained current-state docs |
| `{glossary}` | Domain glossary |
| `{risky-areas}` | Areas that get an extra security pass |
| Repo conventions | Repo docs that also define these rules, and where they differ |

## Architectural work (new subsystems, interface changes)

| #  | Session | Step | Skill / command | Commit |
|----|---------|------|-----------------|--------|
| 1  | 1 Shaping | Shape the idea: questions, 2-3 approaches, sectioned design approval | `superpowers:brainstorming` (architectural path) | — |
| 2  | 1 Shaping | Write spec to `{design-root}specs/YYYY-MM-DD-<topic>-design.md` with `status: draft` frontmatter | `superpowers:brainstorming` (writes the spec) | Hold, don't commit yet |
| 3  | 1 Shaping | Adversarial review: a fresh subagent, given only the spec path, tries to prove the spec wrong against the code. Fix `fix` findings in the spec; `decide` findings become the first grilling round | `/adversarial-spec-review` | — |
| 4  | 1 Shaping | Stress-test the written spec; fold every answer back into it | `/mattpocock-skills:grill-with-docs` (also records ADRs/glossary) or `/mattpocock-skills:grill-me` | — |
| 5  | 1 Shaping | Over-engineering pass on the spec (after grilling, which can add scope) | `ponytail:ponytail-review` | — |
| 6  | 1 Shaping | Approve the spec | — | Confirm, then commit |
| 7  | 2 Planning | Write plan to `{design-root}plans/YYYY-MM-DD-<feature>.md` from the spec alone | `superpowers:writing-plans` (built-in self-review only) | Confirm, then commit |
| 8  | 3 Implementation | Isolated branch/worktree | `superpowers:using-git-worktrees` (SDD runs it at setup) | — |
| 9  | 3 Implementation | Implement task by task, test-first | `superpowers:subagent-driven-development` (per-task review) or `superpowers:executing-plans` (one final reviewer); `superpowers:test-driven-development` inside both | Task commits pre-authorized |
| 10 | 3 Implementation | Prove it works | `superpowers:verification-before-completion`, `{lint}`, `{test}` | — |
| 11 | 4 Final review | Final review | `/full-review {base} high`. After SDD, the per-task spec checks are done; focus on Over-engineering + Correctness | — |
| 12 | 4 Final review | Handle findings | `superpowers:receiving-code-review` | Confirm, then commit |
| 13 | 4 Final review | Distillation gate (see Frontmatter and distillation): spec/plan → `status: shipped`, fill `distilled-to:`, write ADR/learning | `mattpocock-skills:domain-modeling` for ADRs | Confirm, then commit |
| 14 | 4 Final review | Open PR, linking issues with `Closes #N` / `Refs #N` | `superpowers:finishing-a-development-branch`, then `{pr-create}` | — |

### Session splits

Don't run the whole chain in one session. The session that wrote a design or the code is the worst reviewer of it, long sessions get compacted until early decisions survive only as summaries, and a decision that lives only in chat is silently lost at the next stage. The spec, plan, and ledger on disk are the handoffs.

| Session | Starts with | Why separate |
|---------|-------------|--------------|
| 1 Shaping | the idea | Grilling needs the design conversation, so it stays here. The adversarial review gets fresh context as a subagent, no session switch needed. |
| 2 Planning (new) | "Plan from `{design-root}specs/<file>`" | The plan is built from the spec alone. If the planner needs something "we discussed", the spec has a gap: fix the spec. |
| 3 Implementation (new, in the worktree) | "Execute `{design-root}plans/<file>`" | A clean window for the longest run. Plan + ledger make it resumable after a crash or compaction. Native execution runs fine on a mid-tier model. |
| 4 Final review (new, same worktree) | "`/full-review {base} high`" | The implementing session wants it to be done; a fresh one judges it cold. Small fixes happen here rather than in session 3. |

- Sessions 1 and 2 may merge when shaping was short and the context is still small. Never merge 3 and 4.
- Bounded work: one session is fine; `/full-review` already reviews through fresh subagents. Open a new session for the review only if the fix turned into a long debugging hunt.
- PR reviews: one fresh session per PR. Re-reviews after pushes: a new session, or the same review session if it is still small.
- Before ending any session, everything decided goes into the spec or plan.

## Bounded work (most bug fixes, small changes to existing flows)

No spec file, no plan file.

| # | Step | Skill / command |
|---|------|-----------------|
| 1 | Root cause (bugs) | `superpowers:systematic-debugging` or `mattpocock-skills:diagnosing-bugs` |
| 2 | Short design in chat; wait for an explicit yes | `superpowers:brainstorming` (bounded path) |
| 3 | Failing test, then fix | `superpowers:test-driven-development` |
| 4 | Verify + lint | `superpowers:verification-before-completion`, `{lint}`, `{test}` |
| 5 | Final review | `/full-review {base} high` |
| 6 | If the fix surfaced a gotcha, write the learning in `{learnings-dir}` in the same PR | — |
| 7 | Commit (confirm first), draft PR | `superpowers:finishing-a-development-branch`, then `{pr-create}` |

## Reviewing a PR

| #  | Step | Skill / command |
|----|------|-----------------|
| 1  | Context: description, comments, linked issue, CI status | `gh pr view N --repo {pr-repo} --comments`, `gh pr checks N --repo {pr-repo}` |
| 2  | Check out in isolation so the review never touches your branch | `superpowers:using-git-worktrees`, then `gh pr checkout N --repo {pr-repo}` in the worktree |
| 3  | Pin the base: a fork's own `main` can be stale. Fetch, then use the PR's real base | `{base}` |
| 4  | Find the spec. Shipping PR: a `draft` spec/plan or empty `distilled-to:` means unfinished | spec/plan under `{design-root}` in the diff, or the linked issue |
| 5  | Three-way review | `/full-review {base} high` |
| 6  | `{risky-areas}`: extra security pass | `/security-review` |
| 7  | Run it: touched tests + lint | `{lint}`, `{test}` |
| 8  | Verify every finding against the code yourself; drop what you can't confirm | — |
| 9  | Draft comments locally: `bug:` / `risk:` / `nit:` / `q:` prefixes, "we" voice, anchored to file:line. Review drafts before posting | — |
| 10 | Post after approval. The verdict (approve / comment / request changes) is yours | `gh pr review N --repo {pr-repo} --comment` (or `--approve` / `--request-changes`); inline comments via `gh api` |
| 11 | Re-review after new pushes: only commits since the last review, plus whether earlier threads were handled | `/full-review <last-reviewed-sha> high` |

- Skip `code-review --comment`: it posts directly, bypassing the draft read-through and the "we" voice.
- Own PRs: run steps 3–8 before marking ready for review, and fix findings instead of commenting.

## Rules behind it

- **Commits:** always confirm first, except task commits while executing an approved plan on a feature branch. Never skip confirmation on the default branch.
- **Reviews:** no `code-review` on specs or plans; it hunts correctness bugs in diffs. Specs get ponytail-review; plans get writing-plans' self-review.
- **Adversarial review vs grilling:** adversarial review finds what is *wrong* (false claims about the code, unhandled failure paths); grilling finds what is *undecided*. Adversarial runs first so its `decide` findings seed grilling.
- **Grilling:** runs on the written spec, and its answers must land back in the spec. Answers that stay in chat are lost.
- **Subagent models:** no forced `CLAUDE_CODE_SUBAGENT_MODEL` override. Skills pick the model per role (final review on the most capable model).

## Frontmatter and distillation

### Paths

- Specs: `{design-root}specs/YYYY-MM-DD-<topic>-design.md`
- Plans: `{design-root}plans/YYYY-MM-DD-<feature-name>.md`
- Skill defaults (`docs/superpowers/...`) are overridden: always write under `{design-root}`. Specs and plans are committed alongside the code they motivate.

### Frontmatter (every spec and plan, from the first draft)

```yaml
---
status: draft  # draft | shipped | superseded | abandoned
distilled-to:
  - {adr-dir}YYYY-MM-DD-<topic>.md
  - {learnings-dir}<topic>.md
---
```

| Status | Required alongside |
|--------|--------------------|
| `draft` | Nothing. Default until the feature ships (step 2 creates it this way) |
| `shipped` | `distilled-to:` listing at least one durable doc, **or** `distilled-to: none` plus `distillation-skipped-because: <one line>` |
| `superseded` | `superseded-by: <path>` |
| `abandoned` | `abandoned-because: <reason>` |

No other values (no `in-progress`).

### The gate

The PR that ships the feature flips its spec and plan to `shipped` and fills `distilled-to:` (architectural step 13). Cleanest: put the ADR, learning, or current-state doc in the same PR; if one merged earlier, link it. A `draft` spec on a shipping PR is an unfinished task, both for your own PRs and in PR review step 4.

### Where durable knowledge goes

Specs and plans are snapshots: written once, never maintained, so they go stale and are never the source of truth. Distilling into maintained docs is part of finishing the work, not optional cleanup:

| Knowledge | Destination |
|-----------|-------------|
| Material architectural decision | `{adr-dir}YYYY-MM-DD-<slug>.md`: dated, append-only, with Status, Context, Decision, Consequences |
| Non-obvious gotcha, debugging pattern, integration quirk | `{learnings-dir}<topic>.md` |
| Current-state architecture, flows, integration contracts | `{current-docs}` |

Code comments point at these docs with a one-line `Why:` comment naming the doc rather than repeating it.

**Write an ADR when a change:**

- alters how part of the system is structured, deployed, or operated;
- adds, replaces, or removes a third-party dependency or integration;
- establishes a convention other code or contributors are expected to follow;
- reverses or supersedes a prior decision.

Skip it for routine bug fixes, small refactors, dependency bumps, or a rationale that is obvious from the diff. When unsure, write one: they are cheap, and the *why* is the hardest thing to recover later. Propose it alongside the code change, not after.

### Skipping distillation

Allowed when:

- the change is a bug fix that surfaced no new gotcha or constraint;
- the feature is small and its behavior is fully self-evident from the code;
- the change reuses established patterns without introducing new conventions.

The skip must be explicit and reviewable:

```yaml
status: shipped
distilled-to: none
distillation-skipped-because: <one-line rationale>
```

Code review is the check: if the reviewer thinks the work did introduce something worth recording, they push back. When in doubt, write the learning; they are cheap and small.

### Reading old specs and plans

Treat them as history for *why* something was attempted, not a description of how the code works now. Code, ADRs, learnings, and current-state docs are authoritative; verify any claim from a spec or plan against them before acting on it.

## Skills and plugins

Versions as installed on 2026-10-09 (`~/.claude/plugins/cache/`).

### Plugins

| Plugin | Source | Version | Skills used here |
|--------|--------|---------|------------------|
| `superpowers` | `claude-plugins-official` marketplace | 6.4.1 | `brainstorming`, `writing-plans`, `using-git-worktrees`, `subagent-driven-development`, `executing-plans`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `receiving-code-review`, `finishing-a-development-branch` |
| `mattpocock-skills` | GitHub `mattpocock/skills` | 1.2.3 | `grill-with-docs` and `grill-me` (user-invoked; both call `grilling`, and `grill-with-docs` also calls `domain-modeling`), `domain-modeling`, `diagnosing-bugs`, `code-review` (inside `/full-review`) |
| `ponytail` | GitHub `DietrichGebert/ponytail` | 4.10.0 | `ponytail-review` (spec pass and inside `/full-review`) |
| `ruby-lsp` | `claude-plugins-official` marketplace | — | LSP for Ruby repos; no skills |

### Personal skills (`~/.claude/skills/`)

| Skill | Role |
|-------|------|
| `adversarial-spec-review` | Fresh subagent tries to prove a written spec wrong; findings split into `fix` / `decide` |
| `full-review` | Three-way review of a diff: `mattpocock-skills:code-review` (standards + spec), `ponytail:ponytail-review` (over-engineering), built-in `code-review` (correctness) |
| `adding-code-comments` | Ruby repos only (`app/`, `lib/`): default is no comment; `# Why:` pointers to distilled docs |

### Built-in Claude Code skills

| Skill | Role |
|-------|------|
| `code-review` | Correctness pass inside `/full-review` |
| `security-review` | Extra pass on PRs touching `{risky-areas}` |

### Hooks and settings (`~/.claude/settings.json`)

- `PreToolUse` hook `~/.claude/hooks/yard-reminder.sh`: on Ruby edits in `app/` or `lib/`, reminds Claude to follow `adding-code-comments`. Inert in non-Ruby repos.
- `Stop` hook `~/.claude/hooks/kitty-notify.sh`: kitty desktop notification when Claude finishes.
- No `CLAUDE_CODE_SUBAGENT_MODEL` override, so skills choose subagent models themselves.

### Per-repo setup the skills expect

- `docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, `docs/agents/domain.md`: where mattpocock skills find the issue tracker, triage labels, and `{glossary}`. Create them with `/setup-matt-pocock-skills`.
- `{glossary}` and `{adr-dir}`: read by grilling, `domain-modeling`, and `adversarial-spec-review`; created lazily when the first term or decision is resolved.
- `docs/agents/workflow.md` with the Project settings filled in, and a pointer to it from the repo's `CLAUDE.md` / `CLAUDE.local.md` so sessions find it.
