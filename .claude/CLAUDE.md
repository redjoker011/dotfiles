# Personal workflow

Full reference: `~/.claude/workflow.md`. Per-repo values (`{base}`, `{design-root}`, `{lint}`, …) live in the repo's `docs/agents/workflow.md` when it has one. Read the full reference before shaping a spec, writing a plan, running a final review, or reviewing a PR.

- **Commits:** show the diff and wait for my go-ahead before every `git commit`, even when I asked for the commit. Exception: task commits while executing a plan I approved, on a feature branch. Never skip confirmation on the default branch.
- **Path:** bug fixes and small changes to existing flows get a short design in chat, then TDD, then `/full-review`. No spec or plan file.
- **Specs:** write spec → `/adversarial-spec-review` → grill the written spec and fold answers back in → `ponytail:ponytail-review` → my approval → commit. Never run `code-review` on a spec or plan; plans get only writing-plans' self-review.
- **Design docs:** specs and plans go under `{design-root}` (`specs/YYYY-MM-DD-<topic>-design.md`, `plans/YYYY-MM-DD-<feature>.md`), never `docs/superpowers/`. Frontmatter `status:` is `draft | shipped | superseded | abandoned` only. `shipped` needs `distilled-to:` listing a durable doc, or `none` plus `distillation-skipped-because:`. The PR that ships a feature flips it.
- **Sessions:** everything decided goes into the spec or plan before a session ends; the next stage starts from the file, not the chat.
