alias reload "source ~/.config/fish/config.fish | echo "Reloaded!" "

#============= Git Aliases =====================
alias gcd='git checkout development'
alias gfstr='git flow feature start'
alias gffin='git flow feature finish'
# Stash Unstaged Commits
alias gstdu='git stash -k'
# Remove All local branches except master, development and current branch
alias gbx='git branch -D `git branch | grep -vE "master|development"`'
# !!!Force Commit Ignoring Linters
alias gcf='OVERCOMMIT_DISABLE=1 git commit --no-verify'

#============= Command Aliases =====================
alias c='clear'
alias ber='bundle exec rake'
