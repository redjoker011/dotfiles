# set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes

set -x LC_ALL en_US.UTF-8

export TERM=xterm-256color
# export TERMINAL="kitty"
export EDITOR="nvim"
# export DOTBARE_DIR="$HOME/dotfiles"

# sets vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

# FZF settings {{{
 # set -gx FZF_DEFAULT_COMMAND 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
# }}}

# Set the prompt
# function fish_prompt
#     echo -n (set_color red)"$USER@"(prompt_hostname)"❯"
#     echo -n (set_color cyan)(prompt_pwd)"❯"
#     echo -n (set_color red)(git branch 2> /dev/null | awk '{print $2}' | sed '/^\s*$/d')"❯"
#     echo -n " "
# end

# starship init fish | source

# Ensure .aliases.sh exists on $HOME
source $HOME/.aliases.sh
