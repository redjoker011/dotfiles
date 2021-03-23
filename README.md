#s Dotfiles
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

Note: You also need to install [nerd-font](https://github.com/ryanoasis/nerd-fonts) in order for icons to work

Install Haskplex Nerd Font

```
brew install font-haskplex
brew install font-haskplex-nerd
```

**Set Haskplex Nerd as Iterm Font**

`Iterm -> User Preferences -> Profiles`

select `Text` menu and select `Haskplex Nerd` font as preferred font
