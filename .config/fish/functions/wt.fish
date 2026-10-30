function wt --description 'Open or create a git worktree in a new kitty tab, optionally starting claude in it'
    if test (count $argv) -lt 1
        echo "usage: wt <branch | PR number> [claude args...]"
        return 1
    end

    set -l branch $argv[1]
    set -l pr (string match -r '^\d+$' -- $branch)
    set -q pr[1]; and set branch pr-$pr
    set -l main (dirname (realpath (git rev-parse --git-common-dir)))
    set -l repo (basename $main)
    set -l remote upstream
    git remote get-url upstream >/dev/null 2>&1; or set remote origin
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

    # 2. If not, create it next to the main checkout; a PR number checks out the PR's head as pr-<n>
    if test -z "$dir"
        set dir (dirname $main)/$repo-$branch
        if set -q pr[1]
            git fetch $remote pull/$pr/head:$branch; or return 1
            git worktree add $dir $branch; or return 1
        else
            git worktree add $dir -b $branch 2>/dev/null
            or git worktree add $dir $branch
            or return 1
        end
        if test -f $dir/Gemfile
            pushd $dir
            bundle check >/dev/null; or bundle install
            popd
        end
    else if set -q pr[1]
        # Re-review: bring the existing checkout up to the PR's latest head
        git -C $dir pull --ff-only $remote pull/$pr/head; or return 1
    end

    # 3. Extra args start claude in the tab, e.g. wt 2814 "/full-review upstream/main high"
    set -l cmd
    set -q argv[2]; and set cmd fish -c 'claude $argv; exec fish' -- $argv[2..]
    kitten @ launch --type=tab --location=after --cwd=$dir --tab-title="$repo:$branch" $cmd
end
