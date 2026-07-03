# https://github.com/ovv/fzf.fish/blob/5a7d0404c77f0acd81c7b440e21cf28a551c704c/functions/__fzf_search_git_status.fish

function _fzf_git_diff_with_preview --description "Search the output of git status. Replace the current token with the selected file paths."
    # 1. Quick guard clause to reduce nesting
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo (status current-function)": Not in a git repository." >&2
        return 1
    end

    # 2. Extract paths directly inside fzf using awk to handle renames and spaces gracefully
    # We pass the full status line to the preview function so it can read the status flags
    set -l selected_paths (
        git -c color.status=always status --short |
        fzf --ansi --multi \
            --query=(commandline --current-token) \
            --preview='_fzf_preview_changed_file {}' \
            --preview-window='right:60%' \
            --header='Tab: Select multiple, Enter: Accept' \
            | awk '{
                # If it is a rename (starts with R), the new path is after the last "->"
                if ($1 ~ /^R/) {
                    sub(/^.*-> /, "");
                    print $0;
                } else {
                    # Otherwise, strip the 3-character status prefix (XY )
                    print substr($0, 4);
                }
            }'
    )

    # 3. If fzf exited successfully and we actually got selections
    if test $status -eq 0; and set -q selected_paths[1]
        # Properly escape paths for the commandline to handle spaces safely
        commandline --current-token --replace -- (string escape -- $selected_paths | string join ' ')
    end

    commandline --function repaint
end
