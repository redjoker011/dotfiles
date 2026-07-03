# =============================================================================
# 1. System Paths & Environments
# =============================================================================
# Homebrew path (Safely prepends without duplicates)
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/Library/PackageManager/bin

# Environment Variables (Native Fish syntax)
set -gx LC_ALL en_US.UTF-8
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx DOTNET_ROOT /usr/local/share/dotnet
set -gx GOPATH /Volumes/Development/projects/go
set -e GOROOT

# Use Vim as manpager
set -gx MANPAGER "/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

# =============================================================================
# 2. Prompts, Tools & Plugin Initializations
# =============================================================================
# Starship Prompt
starship init fish | source

# Theme Configuration
set -g theme_nerd_fonts yes

# Activate mise (version manager) if present
if type -q mise
    mise activate fish | source
end

# =============================================================================
# 3. Custom Functions
# =============================================================================
# Fixed config reload function
function reload --description "Reload fish configuration"
    source ~/.config/fish/config.fish
    echo "Config reloaded!"
end

# Smart Tmux Session Restorer
function mux --description "Attach or restore tmux session"
    pgrep -vx tmux > /dev/null
    and tmux new -d -s delete-me
    and tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
    and tmux kill-session -t delete-me
    and tmux attach
    or tmux attach
end

# Get the modern primary Git branch (main/trunk/master)
function git_main_branch
    command git rev-parse --git-dir &>/dev/null; or return
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}
        if command git show-ref -q --verify $ref
            set -l branch (string split -r -m1 / $ref)
            echo $branch[2]
            return
        end
    end
    echo master
end


# =============================================================================
# 4. Abbreviations & Aliases (Use 'abbr' for self-expanding terminal shortcuts)
# =============================================================================
# General
abbr -a c clear
abbr -a s ssh
abbr -a cx 'chmod +x'
abbr -a more less
abbr -a cleanup 'rm -f *.tmp *.aux *.log'

# Modern 'ls' (Upgraded from exa to eza)
if type -q eza
    abbr -a ll "eza -l -g --icons"
else if type -q exa
    abbr -a ll "exa -l -g --icons"
end

# Git Core Shortcuts
abbr -a gco git checkout
abbr -a gcd 'git checkout development'
abbr -a gcds 'git checkout dev'
abbr -a gcb 'git checkout -b'
abbr -a gcm 'git checkout (git_main_branch)'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gst 'git status'
abbr -a gbl 'git blame -b -w'
abbr -a gcp 'git cherry-pick'
abbr -a gc 'git commit -v'
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbD 'git branch -D'
abbr -a glg 'git log --stat'
abbr -a glgp 'git log --stat -p'
abbr -a glods "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
abbr -a gm 'git merge'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a gstdu 'git stash -k'
abbr -a gsta 'git stash push'
abbr -a gstaa 'git stash apply'

# Git Push/Pull (Origin)
abbr -a ggpur  'git pull --rebase origin (git branch --show-current)'
abbr -a ggpull 'git pull origin (git branch --show-current)'
abbr -a ggpush 'git push origin (git branch --show-current)'

# Git Push/Pull (Upstream)
abbr -a ggpuru 'git pull --rebase upstream (git branch --show-current)'
abbr -a ggpullu 'git pull upstream (git branch --show-current)'
abbr -a ggpushu 'git push upstream (git branch --show-current)'

# Nuke all local branches except protected ones
abbr -a gbx 'git branch | grep -v "master\|main\|development" | xargs git branch -D'

# Rails & Ruby
abbr -a ber 'bundle exec rake'
abbr -a bs 'bundle exec sidekiq'
abbr -a be 'bundle exec'
abbr -a rc 'bin/rails c'
abbr -a rs 'bin/rails s'
abbr -a rd 'bin/dev'
abbr -a rsb "bin/rails server -p 3000 -b '0.0.0.0'"

# Routes
abbr -a rrr 'bin/rails routes'

# Database
abbr -a rdm 'bin/rails db:migrate'

# If using RSpec (most common)
abbr -a bex 'bundle exec rspec'

# If using default Rails Minitest
abbr -a rt 'bin/rails test'

# Docker & Docker Compose
abbr -a dsprune 'docker system prune -a --volumes'
abbr -a dcb 'docker compose build'
abbr -a dcup 'docker compose up'
abbr -a dcstop 'docker compose stop'

# Vim Muscle Memory Safeties (Kept as traditional aliases)
alias :wq="echo \"This isn't nvim!\""
alias :wq!=:wq
alias :q=:wq
alias :qa=:wq
alias :q!=:wq
alias vi='vim'
alias v='vim'
alias oldvim='\vim'

# =============================================================================
# 5. Key Bindings
# =============================================================================
bind \cg _fzf_search_history # Bind to CTRL+g
bind \cx _fzf_git_diff_with_preview # Bind to CTRL+x
