---
name: conventional-commits
description: Use whenever the user wants help writing a git commit message, setting up a commit message template, following Conventional Commits, or wants their commits to look like feat(scope):/fix(scope):/etc. Trigger this any time the user asks you to "write a commit message", "commit this", "generate a commit", set up a ".git-commit-template" or "commit.template", enforce a commit message convention/style guide, or review/fix a commit message for format. Also trigger if the user mentions Conventional Commits, semantic commits, or asks for help with CHANGELOG-friendly commit history — even if they don't say "template" explicitly.
---

# Conventional Commits (redjoker011 template)

Helps Claude do two related things well:

1. **Install** the bundled `.git-commit-template` into a repo and wire it up via `git config commit.template`.
2. **Write or fix commit messages** — from a staged diff, a description of a change, or an existing bad commit message — so they conform to Conventional Commits and match the style/format of this specific template.

The canonical template is bundled at `assets/git-commit-template.txt`. It is a copy of https://github.com/redjoker011/dotfiles/blob/master/.git-commit-template. Always read it fresh from that path rather than relying on memory of its contents, in case it's been customized.

## Format at a glance

```
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- **Scope**: optional, parenthesized, names the affected area (e.g. `feat(auth): ...`)
- **Breaking change**: append `!` right after the type/scope (e.g. `feat(api)!: drop v1 endpoints`), and/or add a `BREAKING CHANGE: <description>` footer
- **Description**: imperative mood ("add", not "added"/"adds"), lowercase, no trailing period, summary line ≤ 50 chars
- **Body**: wrap at 72 chars, explains *what* and *why*, not *how*
- **Footer**: breaking changes, issue refs (`Fixes #123, Closes #456`), metadata
- Blank line between summary, body, and footer

Two release-flavored scope conventions used by this template:
- `chore(release)` — version bump + changelog for a release
- `docs(changelog)` — standalone CHANGELOG.md/release-notes edits

## Workflow: setting up the template in a repo

1. Copy `assets/git-commit-template.txt` into the target repo, conventionally as `.git-commit-template` at the repo root (or `.gitmessage` if the user prefers that name).
2. Point git at it:
   ```bash
   git config commit.template .git-commit-template
   ```
   Use `git config --global commit.template ~/.git-commit-template` instead if the user wants it applied to every repo, not just the current one.
3. Confirm: `git commit` (no `-m`) will now open the editor pre-filled with the template; running `git commit -m "..."` bypasses it as usual.
4. Mention that the template's lines starting with `#` are comments and get stripped by git automatically — they don't end up in the final commit message.

Don't run `git config` unprompted on a repo you weren't asked to modify — confirm the target repo/path first if it's ambiguous.

## Workflow: writing a commit message

When the user wants an actual commit message for some change (not just the template):

1. Get the change. If they're in a repo Claude has shell access to, prefer looking at the real diff over guessing:
   ```bash
   git diff --staged        # what's about to be committed
   git diff                 # unstaged, if nothing is staged yet
   git status --short
   ```
   If Claude doesn't have shell access to their repo, ask them to paste the diff or describe the change.
2. Pick the single most accurate `type`. If a change is genuinely mixed (e.g. a feature plus its docs), prefer the type of the primary change and mention the rest in the body, rather than inventing multiple types on one line. Suggest splitting into separate commits if the diff is doing unrelated things.
3. Derive a short scope from the affected module/directory/feature when it's obvious; omit scope rather than guessing wildly.
4. Write the summary line: imperative, lowercase, no period, ≤ 50 chars. Add a body only if the *why* isn't obvious from the summary alone — don't pad a trivial change with a manufactured body.
5. Add `!` and/or a `BREAKING CHANGE:` footer only if the change actually breaks a public API/contract — don't apply it defensively.
6. Add issue references in the footer only if the user mentions an issue/ticket number.
7. Present the final message in a fenced code block, formatted exactly as it should be typed/piped, e.g.:
   ```
   feat(auth): add OAuth2 provider support

   Adds a pluggable provider interface so new OAuth backends can be
   registered without touching the core login flow.

   Closes #456
   ```
   If asked to actually make the commit, use `git commit -m "summary" -m "body"` (repeat `-m` for each paragraph) or open the templated editor per the setup workflow above — check with the user before committing on their behalf.

## Workflow: reviewing/fixing an existing message

If given a commit message (e.g. `git log -1 --pretty=%B`, or pasted text) to check:
- Verify it has a valid `type`, correct casing/mood/punctuation, and ≤ 50 char summary.
- Flag breaking changes that lack `!` or a `BREAKING CHANGE:` footer, and vice versa.
- Rewrite it to comply, showing before/after, and note that rewriting history requires `git commit --amend` (last commit only) or an interactive rebase (`git rebase -i`) for older commits — both rewrite history, so warn before suggesting it on anything already pushed/shared.
