alias reload "source ~/.config/fish/config.fish | echo "Reloaded!" "

alias mux='pgrep -vx tmux > /dev/null && \
		tmux new -d -s delete-me && \
		tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
		tmux kill-session -t delete-me && \
		tmux attach || tmux attach'

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
alias cpr='bundle exec cap production mb:sidekiq:stop mb:unicorn:stop mb:unicorn:start mb:sidekiq:start'
alias csr='bundle exec cap staging mb:sidekiq:stop mb:unicorn:stop mb:unicorn:start mb:sidekiq:start'
alias cpds='cap production db:local:sync && bin/rails db:environment:set RAILS_ENV=development'
alias csds='cap staging db:local:sync && bin/rails db:environment:set RAILS_ENV=development'
alias rdm='bin/rails db:migrate && bin/rails db:migrate RAILS_ENV=test'
alias rdr='bin/rails db:rollback && bin/rails db:rollback RAILS_ENV=test'
alias rdc='DISABLE_DATABASE_ENVIRONMENT_CHECK=1 && bin/rails db:drop && bin/rails db:create RAILS_ENV=development'
alias rds='bin/rails db:drop && bin/rails db:create && bin/setup'
alias rs='bin/spring stop && rails s'
alias rc='bin/spring stop && rails c'
alias bs='bundle exec sidekiq'
alias brt='bundle exec rake test'
alias br='bundle exec rake'
alias rt='ruby -Itest'
# Yarn Aliases
alias ys='yarn serve'
alias ysd='yarn serve:dev'
alias ytu='yarn test:unit'
alias yte='yarn test:e2e'
# NPM Aliases
alias ns='npm run serve'
alias ntu='npm run test:unit'
alias pns='pnpm run serve'
alias pntu='pnpm run test:unit'

#=========== Vim aliases ==========================
# https://www.reddit.com/r/vim/comments/42fwjx/when_vim_leaves_a_trail/cza0azv
alias :wq="echo \"This isn't nvim!\""
alias :wq!=:wq
alias :q=:wq
alias :qa=:wq
alias :q!=:wq
# Map vim and vi command to nvim because nvim is cool
# vim: Defaults to Neovim if exists
if command -v nvim 2>&1 >/dev/null; then
    alias vim='nvim'
fi
alias vi='vim'
alias v='vim'
alias oldvim='\vim'

# Useful aliases
alias s=ssh
alias cx='chmod +x'
alias more=less
alias cleanup='rm -f *.tmp *.aux *.log'
alias cleanupds='find . -type f -name '*.DS_Store' -ls -delete'

#================ brew ============================
alias bri='brew install'
alias bru='brew uninstall'
alias brs='brew search'
alias brsl='brew services list'
alias brsp='brew services stop'
alias brsr='brew services restart'
alias brss='brew services start'
alias brci='brew cask install'
alias brcu='brew cask uninstall'
alias brcs='brew cask search'
alias brewup='brew update && brew upgrade && brew cask upgrade'


#================ docker ============================
alias dk='docker'
alias dksa='docker stop (docker ps -a -q)'
alias dkda='docker rm (docker ps -a -q)'
alias dkdv='docker volume rm (docker volume ls -q)'
alias dkst='docker stats --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}''
alias dkc='docker-compose'
alias dke='docker exec -it'
alias dkm='docker-machine'

# Useful functions

# Make Directory and CD
mcd() { mkdir -p $1; cd $1 }

# CD to directory and list
cdl() { cd $1; ls}

# Backup file and test
backup() { cp "$1"{,.bak};}

# Global find
gfind() { find / -iname $@ 2>/dev/null }

# Local find
lfind() { find . -iname $@ 2>/dev/null }

# Search on google
rtfm() { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }

# SSH into Host with identity file
func letmein() {
  ssh -i ~/Downloads/Chatgenie-2020.pem ubuntu@"$1"
}

#============== Go Workspace Configuration ==================
#========= Set Go Workspace
export GOPATH=$HOME/go
#========= Set Go Executable on Directory Path
export PATH=$HOME/go/bin/:$PATH

# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# Replace ag with RIPgrep
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

export TERM=xterm-256color

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.rbenv/bin:$PATH"

# GIT heart FZF
# -------------
# https://junegunn.kr/2015/03/browsing-git-commits-with-fzf
# fshow - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
fzhow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

fgf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

fgb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

fgt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

fgh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

fgr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" --remotes={1} | head -200' |
  cut -d$'\t' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper
