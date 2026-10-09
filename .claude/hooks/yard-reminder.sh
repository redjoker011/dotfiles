#!/usr/bin/env bash
# PreToolUse: remind Claude to follow adding-code-comments on Ruby edits in app/ or lib/.
path=$(jq -r '.tool_input.file_path // empty')
[[ "$path" =~ /(app|lib)/.*\.rb$ ]] || exit 0
jq -n '{hookSpecificOutput: {hookEventName: "PreToolUse",
  additionalContext: "Ruby edit in app/ or lib/: follow the adding-code-comments skill. Default is no comment. Delete redundant or stale comments on code you touch; keep only a one-line # Why: or a pointer to a distilled doc."}}'
