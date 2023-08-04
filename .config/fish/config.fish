fish_add_path /opt/homebrew/bin

starship init fish | source

# set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes

set -x LC_ALL en_US.UTF-8

export TERM=xterm-256color
# export TERMINAL="kitty"
export EDITOR="nvim"
# export DOTBARE_DIR="$HOME/dotfiles"

# sets vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

# Override Default fzf bindings
# Change bindings based on your preference
fzf_configure_bindings --git_status=\cs --history=\ch --variables=\cv --directory=\cf --git_log=\cl

# =============== General Aliases =====================
alias reload "source ~/.config/fish/config.fish | echo "Reloaded!" "

if type -q exa
  alias ll "exa -l -g --icons"
end

alias mux='pgrep -vx tmux > /dev/null && \
		tmux new -d -s delete-me && \
		tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
		tmux kill-session -t delete-me && \
		tmux attach || tmux attach'

#============= Git Aliases =====================
# Refs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

# Check if main exists and use instead of master
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh#L33
function git_main_branch
  command git rev-parse --git-dir &>/dev/null || return $ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}
    if command git show-ref -q --verify $ref
      set branch (string split -r -m1 / $ref)
			echo $branch[2]
      return
    end
  end
  echo master
end

alias gcm='git checkout '(git_main_branch)''

function __git_prompt_git
  echo (GIT_OPTIONAL_LOCKS=0 command git $argv)
end

function git_current_branch
  command git symbolic-ref --short HEAD 2>/dev/null
end

function _git_current_branch
  set -l ref (__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)
  set -l ret $status

  if test ! $ret = 0
    test $ret -eq 128 && return  # no git repo.
    set ref (__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  end
  # echo {$ref#refs/heads/}
  echo $ref
end

alias gcd='git checkout development'
alias gcds='git checkout dev'
alias gcb='git checkout -b'
alias gco='git checkout'

alias ga='git add'
alias gaa='git add --all'

alias gst='git status'

alias gbl='git blame -b -w'

alias gcp='git cherry-pick'

alias gc='git commit -v'

alias gb='git branch'
alias gba='git branch -a'
alias gbD='git branch -D'

alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"

# Git Flow Aliases
# Ref: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git-flow/git-flow.plugin.zsh
alias gflfs='git flow feature start'
alias gflff='git flow feature finish'
alias gflhs='git flow hotfix start'
alias gflhf='git flow hotfix finish'
alias gflrs='git flow release start'
alias gflrf='git flow release finish'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'

alias ggpur='git pull --rebase origin '(git_current_branch)''
alias ggpull='git pull origin '(git_current_branch)''
alias ggpush='git push origin '(git_current_branch)''

alias gm='git merge'

# Stash Unstaged Commits
alias gstdu='git stash -k'
alias gsta='git stash push'
alias gstaa='git stash apply'

# Remove All local branches except master, development and current branch
alias gbx='git branch | grep -v "master\|main\|development" | xargs git branch -D'

# !!!Force Commit Ignoring Linters
alias gcf='OVERCOMMIT_DISABLE=1 git commit --no-verify'

#============= Command Aliases =====================
alias c='clear'
alias ber='bundle exec rake'
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

# Vim aliases
# https://www.reddit.com/r/vim/comments/42fwjx/when_vim_leaves_a_trail/cza0azv
alias :wq="echo \"This isn't nvim!\""
alias :wq!=:wq
alias :q=:wq
alias :qa=:wq
alias :q!=:wq

alias vi='vim'
alias v='vim'
alias oldvim='\vim'

# Useful aliases
alias s=ssh
alias cx='chmod +x'
alias more=less
alias cleanup='rm -f *.tmp *.aux *.log'

set PYENV_ROOT "/opt/homebrew/bin/pyenv"

# Temporarily bind CTRL+X to _fzf_search_git_status_with_preview
# !Experimental
bind \cx _fzf_search_git_status_with_preview

export PATH="$PATH:$HOME/Library/PackageManager/bin"

set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths

# Initialize Ruby Manager rbenv
status --is-interactive; and rbenv init - fish | source

# Initialize nvm
function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# This is pre-requisite for Omnisharp-vim to work
# @see issue: https://github.com/OmniSharp/omnisharp-vim/issues/798
export DOTNET_ROOT=/usr/local/share/dotnet

export GOPATH=/Volumes/Development/projects/go
export GOBIN=/Volumes/Development/projects/go/bin
export GOROOT=/usr/local/go
