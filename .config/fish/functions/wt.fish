function wt --description 'Open or create a git worktree in a new kitty tab'
    if test (count $argv) -ne 1
        echo "usage: wt <branch>"
        return 1
    end

    set -l branch $argv[1]
    set -l dir

    # 1. Is this branch already checked out in some worktree?
    set -l current
    for line in (git worktree list --porcelain)
        if string match -q 'worktree *' -- $line
            set current (string replace 'worktree ' '' -- $line)
        else if test "$line" = "branch refs/heads/$branch"
            set dir $current
            break
        end
    end

    # 2. If not, create it
    if test -z "$dir"
        set dir "../"(basename $PWD)"-$branch"
        git worktree add $dir -b $branch 2>/dev/null
        or git worktree add $dir $branch
        or return 1
        set dir (realpath $dir)
    end

    set -l repo (basename (dirname (realpath (git rev-parse --git-common-dir))))
    kitten @ launch --type=tab --location=after --cwd=$dir --tab-title="$repo:$branch"
end
