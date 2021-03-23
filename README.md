# Dotfiles
Collection of helpful developer's dotfiles configurations
* Tmux
* Vim
* Zsh
* Git Commit Message Template
* Vscode

# Installation

## Tmux

Install tmux

```
# MacOs
brew install tmux
# Ubuntu
apt install tmux
```
https://github.com/tmux/tmux/wiki/Installing

Clone repository `git clone git@github.com:redjoker011/dotfiles.git`

Copy `.tmux.conf` and `.tmux.conf.local` in your local directory

```
ln -s -f .dotfiles/.tmux.conf
cp .dotfiles/.tmux.conf.local .
```

Then proceed to customize your ~/.tmux.conf.local copy.
