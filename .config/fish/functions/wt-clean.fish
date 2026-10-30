function wt-clean --description 'Remove worktrees and branches whose upstream PR is merged or closed'
    set -l url (git remote get-url upstream 2>/dev/null; or git remote get-url origin)
    set -l repo (string replace -r '.*github\.com[:/](.+?)(\.git)?$' '$1' -- $url)

    # 1. Find worktrees (skipping the main checkout) whose PR is done and that hold no local-only work
    set -l paths (git worktree list --porcelain | string replace -rf '^worktree ' '')
    set -e paths[1]
    set -l wts
    set -l branches
    for wt in $paths
        set -l branch (git -C $wt branch --show-current)
        test -n "$branch"; or continue

        set -l pull (string match -r '^pull/(\d+)/head$' -- $branch)
        set -l state
        if set -q pull[2]
            set state (gh pr view $pull[2] --repo $repo --json state --jq .state)
        else
            set state (gh pr list --repo $repo --head $branch --state all --json state --jq '.[0].state')
        end
        contains -- "$state" MERGED CLOSED; or continue

        set -l dirty (git -C $wt status --porcelain)
        set -l unpushed (git -C $wt log --oneline @{u}.. 2>/dev/null)
        if set -q dirty[1]; or set -q unpushed[1]
            echo "skip $branch ($state, but has uncommitted or unpushed work)"
            continue
        end

        echo "$state  $branch  $wt"
        set -a wts $wt
        set -a branches $branch
    end

    if not set -q wts[1]
        echo "nothing to clean"
        return
    end

    # 2. Remove them after one confirmation; origin is the fork, so only non-pull/ branches live there
    read -P "Remove these worktrees, local branches, and origin branches? [y/N] " answer
    test "$answer" = y; or return

    for i in (seq (count $wts))
        set -l branch $branches[$i]
        git worktree remove $wts[$i]; or continue
        git branch -D $branch
        if not string match -q 'pull/*' -- $branch
            and git ls-remote --exit-code --heads origin $branch >/dev/null
            git push origin --delete $branch
        end
    end
    git worktree prune
end
