function wt-clean --description 'Remove worktrees, local branches, and fork branches whose upstream PR is merged or closed'
    set -l url (git remote get-url upstream 2>/dev/null; or git remote get-url origin)
    set -l repo (string replace -r '.*github\.com[:/](.+?)(\.git)?$' '$1' -- $url)

    # 1. Gather worktrees (the main checkout's branch is kept), local branches, and fork branches
    set -l main (git worktree list --porcelain | string replace -rf '^worktree ' '')[1]
    set -l keep main master development
    set -l wt_paths
    set -l wt_branches
    set -l current
    for line in (git worktree list --porcelain)
        if string match -q 'worktree *' -- $line
            set current (string replace 'worktree ' '' -- $line)
        else if string match -q 'branch refs/heads/*' -- $line
            set -l b (string replace 'branch refs/heads/' '' -- $line)
            if test "$current" = "$main"
                set -a keep $b
            else
                set -a wt_paths $current
                set -a wt_branches $b
            end
        end
    end
    set -l locals (git for-each-ref --format='%(refname:short)' refs/heads)
    set -l remotes (git ls-remote --heads origin | string replace -rf '.*\trefs/heads/' '')
    # One call for every PR I opened, newest first: "<branch> <state> <head sha>"
    set -l mine (gh pr list --repo $repo --author @me --state all --limit 1000 \
        --json headRefName,state,headRefOid --jq '.[] | "\(.headRefName) \(.state) \(.headRefOid)"')
    or return 1

    # 2. Keep only branches whose PR is done and that hold no work the PR lacks
    set -l todo
    for branch in (printf '%s\n' $locals $remotes | sort -u)
        contains -- $branch $keep; and continue

        # Review checkouts from `wt <n>` (pr-<n>), or the older pull/<n>/head
        set -l n (string replace -rf '^(?:pr-|pull/)(\d+)(?:/head)?$' '$1' -- $branch)
        set -l state
        set -l oid
        if set -q n[1]
            set state (gh pr view $n --repo $repo --json state --jq .state)
        else
            set -l hits (string replace -rf '^'(string escape --style=regex -- $branch)' ' '' -- $mine)
            string match -q 'OPEN *' -- $hits; and continue
            set -l f (string split ' ' -- "$hits[1]")
            set state $f[1]
            set oid $f[2]
        end
        contains -- "$state" MERGED CLOSED; or continue

        set -l i (contains -i -- $branch $wt_branches)
        if set -q i[1]
            set -l dirty (git -C $wt_paths[$i] status --porcelain)
            if set -q dirty[1]
                echo "skip $branch ($state, uncommitted changes in $wt_paths[$i])"
                continue
            end
        end
        # Review branches are copies of someone else's PR, so only own branches get the commit check
        if test -n "$oid"; and contains -- $branch $locals
            set -l extra (git rev-list refs/heads/$branch --not $oid 2>/dev/null; or echo unknown)
            if set -q extra[1]
                echo "skip $branch ($state, local commits beyond the PR head, or that head isn't fetched)"
                continue
            end
        end

        set -l where
        set -q i[1]; and set -a where $wt_paths[$i]
        contains -- $branch $locals; and set -a where local
        contains -- $branch $remotes; and set -a where origin
        echo "$state  $branch  ($where)"
        set -a todo $branch
    end

    if not set -q todo[1]
        echo "nothing to clean"
        return
    end

    # 3. Remove them after one confirmation
    read -P "Remove these worktrees, local branches, and origin branches? [y/N] " answer
    test "$answer" = y; or return

    set -l fork_deletes
    for branch in $todo
        set -l i (contains -i -- $branch $wt_branches)
        if set -q i[1]
            git worktree remove $wt_paths[$i]; or continue
            # Drop the empty parent folders a nested path like rialto-pull/<n>/head leaves behind
            set -l d (dirname $wt_paths[$i])
            while rmdir $d 2>/dev/null
                set d (dirname $d)
            end
        end
        contains -- $branch $locals; and git branch -D $branch
        contains -- $branch $remotes; and set -a fork_deletes $branch
    end
    set -q fork_deletes[1]; and git push origin --delete $fork_deletes
    git worktree prune
end
