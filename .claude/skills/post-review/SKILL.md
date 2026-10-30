---
name: post-review
description: Use when turning /full-review findings into GitHub PR comments ("draft comment for 1 and 3", "draft an approval comment", "post comments"), or replying to existing review threads on a PR.
---

# Post Review

Turns numbered Approval Check items into one GitHub review: inline comments on diff lines plus a short body. Every run is **draft, show, post**: nothing reaches GitHub until the user approves the exact text.

Args: item numbers and the event. Items default to every item in both Approval Check lists. Event is `comment` (default), `approve`, or `request-changes`; the verdict is the user's call.

## Process

1. **Pin the PR.** `gh pr view --json number,headRefOid,url` from the checkout. Repo: `{pr-repo}` from `docs/agents/workflow.md`, else the PR's own repo. Items come from the latest `## Approval Check` in this session; with none in context, ask the user to run `/full-review` first. Items tagged `(already raised: @user)` stay out unless the user names them.
2. **Anchor each item** at `headRefOid`. Confirm the finding still holds in the code. An inline comment must sit on a line `gh pr diff` shows (added or context line, `side: RIGHT`); a finding whose line is outside the diff goes in the review body with its `path:line`.
3. **Draft** to `<scratchpad>/pr-<n>-review.json`:
   ```json
   {
     "commit_id": "<headRefOid>",
     "event": "COMMENT",
     "body": "<summary>",
     "comments": [
       {"path": "app/models/x.rb", "line": 42, "side": "RIGHT", "body": "risk: ..."}
     ]
   }
   ```
   A range adds `"start_line"` and `"start_side": "RIGHT"`. Event is `COMMENT`, `APPROVE`, or `REQUEST_CHANGES`. On the user's own PR GitHub accepts only `COMMENT`.
4. **Voice**, for every comment and the body:
   - Open with a plain-text prefix: `bug:`, `risk:`, `q:`, or `nit:`.
   - Speak as the team: we / us / our. The one first-person line allowed is "I'm happy to approve".
   - One finding per comment, two to four sentences: what breaks, the input or state that breaks it, and what would clear it. Cite other code as `path:line`.
   - Body: one or two sentences carrying the verdict. For approve-with-nits, say the raised points don't block.
5. **Show the draft** as GitHub will render it: the body, then each comment as `path:line` and its text. Apply the user's edits to the JSON and show it again. The step is done when the user explicitly approves this version.
6. **Post**, then report the review URL:
   ```sh
   gh api -X POST repos/{pr-repo}/pulls/<n>/reviews --input <file> -q .html_url
   ```
   A `422` naming a line outside the diff: move that comment into the body, show the change, and post after approval.

## Replies to existing threads

Draft each reply under the same voice rules, show them, and post after approval:

```sh
gh api -X POST repos/{pr-repo}/pulls/<n>/comments/<comment-id>/replies -f body='<text>'
```

Find comment ids with `gh api repos/{pr-repo}/pulls/<n>/comments --paginate --jq '.[] | {id, path, line, user: .user.login, body: .body[0:120]}'`.
