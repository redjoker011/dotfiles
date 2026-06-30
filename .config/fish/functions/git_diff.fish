function git_diff --description 'Interactively preview git diffs using fzf'
    # Get the selected file from fzf
    set -l file (git status -s | fzf --preview 'git diff --color=always (string split " " $argv)[-1]' | string split " ")[-1]

    # If a file was selected, clear the screen and show its full diff
    if test -n "$file"
        git diff $file
    end
end
