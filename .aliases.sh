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

#============= Command Aliases =====================
alias c='clear'
alias ber='bundle exec rake'
alias cpr='bundle exec cap production mb:sidekiq:stop mb:unicorn:stop mb:unicorn:start mb:sidekiq:start'
alias csr='bundle exec cap staging mb:sidekiq:stop mb:unicorn:stop mb:unicorn:start mb:sidekiq:start'
alias cpds='cap production db:local:sync && bin/rails db:environment:set RAILS_ENV=development'
alias csds='cap staging db:local:sync && bin/rails db:environment:set RAILS_ENV=development'
alias rdm='bin/rails db:migrate && bin/rails db:migrate RAILS_ENV=test'
alias rdr='bin/rails db:rollback && bin/rails db:rollback RAILS_ENV=test'
alias rdcr='DISABLE_DATABASE_ENVIRONMENT_CHECK 1 && bin/rails db:drop && bin/rails db:create RAILS_ENV=development'
alias rds='bin/rails db:drop && bin/rails db:create && bin/setup'
alias rs='bin/spring stop && rails s'
alias rc='bin/spring stop && rails c'
alias bs='bundle exec sidekiq'
alias brt='bundle exec rake test'
alias br='bundle exec rake'
alias rt='ruby -Itest'
# Yarn Aliases
alias ys='yarn serve'
alias ysrd='yarn serve:dev'
alias ystd='yarn start:dev'
alias ytu='yarn test:unit'
alias yte='yarn test:e2e'
# NPM Aliases
alias ns='npm run serve'
alias ntu='npm run test:unit'

# Vim aliases
# https://www.reddit.com/r/vim/comments/42fwjx/when_vim_leaves_a_trail/cza0azv
alias :wq="echo \"This isn't nvim!\""
alias :wq!=:wq
alias :q=:wq
alias :qa=:wq
alias :q!=:wq
# Map vim and vi command to nvim because nvim is cool
# vim: Defaults to Neovim if exists
if command -v nvim 2>&1 >/dev/null
	alias vim='nvim'
end

alias vi='vim'
alias v='vim'
alias oldvim='\vim'

# Useful aliases
alias s=ssh
alias cx='chmod +x'
alias more=less
alias cleanup='rm -f *.tmp *.aux *.log'
