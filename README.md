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

Then create a symlink for `dotfiles/.config/fish` on your `.config` directory

```
$ cd dotfiles
$ ln -s .config/fish $HOME/.config
```

### Plugin Manager

Install [fisher](https://github.com/jorgebucaran/fisher) as plugin manager

```
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
```

Install all required plugins using `fisher update`

### Plugins

- [fisher](https://github.com/jorgebucaran/fisher) - Fish Plugin Manager
- [z](https://github.com/jethrokuan/z) - Directory Jumping Plugin
- [exa](https://github.com/ogham/exa) - LS Replacement
- [ghq](https://github.com/x-motemen/ghq) - Repository Manager like Go Get
- [tide](https://github.com/IlanCosman/tide) - Prompt manager for Fish
  - Run `tide configure` on your terminal to configure Prompt Style
  - Also check install this [Nerd Font](https://github.com/IlanCosman/tide#meslo-nerd-font) for icons to work 
- [fzf-fish](https://github.com/PatrickF1/fzf.fish) Fzf bindings for Fish

Note: This Plugins are manually installed and are required plugins for `fzf-fish`.
Please click on each item to view installation guide

- [fzf](https://github.com/junegunn/fzf#installation) Command Line Fuzzy Finder
- [fd](https://github.com/sharkdp/fd#installation) Replacement to find
- [bat](https://github.com/sharkdp/bat#installation) Syntax Highlightning

Note: Check this [guide](https://fishshell.com/docs/current/#default-shell) on how to make fish your default shell

TLDR;

- Add the line /usr/local/bin/fish to /etc/shells.
- Change your default shell with chsh -s /usr/local/bin/fish.

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

- Git Flow
  - `gflfs` Alias for git flow feature start
  - `gflff` Alias for git flow feature finish
  - `gflhs` Alias for git flow hotfix start
  - `gflhf` Alias for git flow hotfix finish
  - `gflrs` Alias for git flow release start
  - `gflrf` Alias for git flow release finish

- Stash
  - `gstdu` Stash All unstaged commits

- Branch
  - `gb` Display existing branches
  - `gba` Display all branches
  - `gbD` Delete branch
  - `gbx` Delete all local git branches aside from main|master|development

- Commit
  - `ga` Alias for git add
  - `gaa` Alias for git add --al
  - `gst` Alias for git status
  - `gcp` Alias for git cherry-pick
  - `gc` Alias for git commit -v

  - `gcf` Alias for git commit disabling Overcommit(Ruby) and Husky(Node)

- Checkout
  - `gcm` Checkout to main branch
  - `gcd` Checkout to development branch
  - `gcb` Checkout to new branch e.g gcb feature/test1
  - `gco` Alias to git checkout

- Pull
  - `ggpur` Pull and Rebase
  - `ggpull` Pull Remote Changes
  - `ggpush` Push Local Changes to Remote

- History
  - `gbl` Alias to git blame -b -w
  - `grb` Alias to git rebase
  - `grba` Alias to git rebase --abort
  - `grbc` Alias to git rebase --continue
  - `grbi` Alias to git rebase -i

- Log
  - `glg` Alias to git log --stat
  - `glgp` Alias to git log --stat -p
  - `glgp` Alias to git log --graph with styles


#### Yarn

- `ys` Alias to yarn serve
- `yss` Alias to yarn serve:dev
- `ystd` Alias to yarn start:dev
- `ytu` Alias to yarn test:unit
- `yte` Alias to yarn test:e2e

### Bindings

#### Z

- `z` Let's you jump on between directories

#### Exa

- `ll` View directory contents with color and icons

#### FZF

- `CTRL+F` Query File Paths and Directories
- `CTRL+S` Query and Preview Modified Files in a Git Repository
- `CTRL+L` Query and Preview Logs in a Git Repository
- `CTRL+H` Query List of Previously Run Commands(History)
- `CTRL+V` Query List of Environment Variables in Current Scope


# Acknowledgements

- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) - Reference for most of git and git flow aliases
