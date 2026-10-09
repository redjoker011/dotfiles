# Claude Code config

Personal Claude Code setup: global instructions, the spec-to-review workflow, and my own skills.
Built on three plugins: `superpowers`, `mattpocock-skills`, `ponytail` (versions pinned in `workflow.md`).

## Layout

| Path | Installs to | Purpose |
|------|-------------|---------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | Always-on rules: commit confirmation, path choice, spec pipeline, design-doc frontmatter, session handoffs |
| `workflow.md` | `~/.claude/workflow.md` | Full reference: architectural / bounded / PR-review paths, session splits, frontmatter + distillation, plugin inventory |
| `skills/full-review/` | `~/.claude/skills/full-review/` | `/full-review [fixed-point] [level]`: three-way diff review (standards + spec, over-engineering, correctness) |
| `skills/adversarial-spec-review/` | `~/.claude/skills/adversarial-spec-review/` | `/adversarial-spec-review [spec]`: fresh subagent tries to prove a draft spec wrong; `fix` / `decide` findings |
| `skills/conventional-commits/` | `~/.claude/skills/conventional-commits/` | Write/fix Conventional Commit messages; installs `.git-commit-template` |

## Install

Symlink so this repo stays the source of truth:

```bash
ln -sf "$PWD/.claude/CLAUDE.md"   ~/.claude/CLAUDE.md
ln -sf "$PWD/.claude/workflow.md" ~/.claude/workflow.md
for s in .claude/skills/*/; do ln -sfn "$PWD/$s" ~/.claude/skills/; done
```

Requires the plugins listed in `workflow.md` → *Skills and plugins*.

## Per-repo setup

The workflow uses placeholders (`{base}`, `{design-root}`, `{lint}`, `{test}`, …).
Each repo defines them in `docs/agents/workflow.md` (excluded via `.git/info/exclude`), pointed to from its `CLAUDE.md` / `CLAUDE.local.md`.
Copy the *Project settings* table from `workflow.md` to start; run `/setup-matt-pocock-skills` for the `docs/agents/*` files the mattpocock skills read.

## Flow at a glance

- **Bounded** (bug fixes, small changes): debug → design in chat → TDD → `/full-review` → confirm commit
- **Architectural**: brainstorm → spec → `/adversarial-spec-review` → grill → `ponytail-review` → approve → plan → worktree + implement → `/full-review` → distill → PR
- **PR review**: fresh session + worktree per PR, `/full-review` against the real base, draft comments locally before posting

Not tracked here yet: `~/.claude/skills/adding-code-comments`, `~/.claude/hooks/{yard-reminder,kitty-notify}.sh`, `settings.json`.
