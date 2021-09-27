#Dotfiles
Collection of helpful developer's dotfiles configurations
* Tmux
* Vim
* Zsh
* Git Commit Message Template
* Vscode
* Fish

# Installation

Clone repository `git clone git@github.com:redjoker011/dotfiles.git`

## Tmux

Install tmux

```
# MacOs
brew install tmux
# Ubuntu
apt install tmux
```
https://github.com/tmux/tmux/wiki/Installing

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

## Git Commit Template

Set git commit template using `git config --global commit.template ~/dotfiles/.git-commit-template`

## Fish

Please follow this official [guide](https://github.com/fish-shell/fish-shell#getting-fish) on installing Fish on your respective platforms.

### Plugins

- [fisher](https://github.com/jorgebucaran/fisher) - Fish Plugin Manager
- [peco](https://github.com/peco/peco) - Interactive Filtering Tool
- [z](https://github.com/jethrokuan/z) - Directory Jumping Plugin
- [exa](https://github.com/ogham/exa) - LS Replacement
- [ghq](https://github.com/x-motemen/ghq) - Repository Manager like Go Get
- [tide](https://github.com/IlanCosman/tide) - Prompt manager for Fish

### Plugin Manager

Install [fisher](https://github.com/jorgebucaran/fisher) as plugin manager

```
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
```

# Commands and Bindings

This section contains available commands and their usage for each packages.

## Fish

### Commands

#### General

- `c` Alias to clear
- `s` Alias to ssh
- `cx` Alias to chmod +x
- `more` Alias to less
- `cleanup` Remove *.tmp, *.aux and *.log files on current directory
- `cdl` Navigate to directory and list files e.g `cdl dotfiles`
- `backup` Create a backup for a file e.g `backup README.md -> README.md.bak`
- `gfind` Globally search for a file e.g `gfind README.md`
- `lfind` Locally search for a file e.g `lfind README.md`
- `mcd` Create directory and Navigate to it `mcd dotfiles`
- `vim` Open Neovim if exists and vim by default
- `reload` Reload fish config

#### Ruby on Rails

- `ber` Alias to bundle exec rake
- `rdm` Alis to bundle exec rake db:migrate
- `rdr` Alis to bundle exec rake db:rollback
- `rdcr` Alis to bundle exec rake db:create
- `rds` Alis to bundle exec rake db:setup
- `rs` Start Rails Server
- `rc` Start Rails Console
- `bs` Start Sidekiq
- `brt` Alias to bundle exec rake:test
- `rt` Alias to Minitest ruby -Itest

#### Git

- `gcd` Alias for git checkout
- `gfstr` Alias for git flow feature start
- `gffin` Alias for git flow feature finish
- `gstdu` Stash All unstaged commits
- `gbx` Delete all local git branches aside from main|master|development
- `gcf` Alias for git commit disabling Overcommit(Ruby) and Husky(Node)

#### Yarn

- `ys` Alias to yarn serve
- `yss` Alias to yarn serve:dev
- `ystd` Alias to yarn start:dev
- `ytu` Alias to yarn test:unit
- `yte` Alias to yarn test:e2e

### Bindings

#### Peco

- `CTRL + r` View Directories
- `CTRL + f` View History

#### Z

- `z` Let's you jump on between directories

#### Exa

- `ll` View directory contents with color and icons
