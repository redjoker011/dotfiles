Collection of helpful tool configurations that I used on my day by day coding ⌨️

![](./assets/ui.png)

- [Tmux](#tmux)
- [Git Commit Message Template](#git-commit-template)
- [Fish(Shell)](#fish)
- [Starship(Shell Prompt)](#starship)

# Installation

Clone repository `git clone git@github.com:redjoker011/dotfiles.git`

## Pre-requisites

### Nerd Font

Install FiraCode Nerd Font from [here](https://www.nerdfonts.com/font-downloads)

source: https://github.com/huytd/haskplex-font

### Fish

Please follow this official [guide](https://github.com/fish-shell/fish-shell#getting-fish) on installing Fish on your respective platforms.

Then create a symlink for `dotfiles/.config/fish` on your `.config` directory

```
$ cd dotfiles
$ ln -s .config/fish $HOME/.config
```

#### Plugin Manager

Install [fisher](https://github.com/jorgebucaran/fisher) as plugin manager

```
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
```

Install all required plugins using `fisher update`

##### Plugins

- [fisher](https://github.com/jorgebucaran/fisher) - Fish Plugin Manager
- [z](https://github.com/jethrokuan/z) - Directory Jumping Plugin
- [exa](https://github.com/ogham/exa) - LS Replacement
  - If exa doesn't work you might need to install it manually by following this [guide](https://github.com/ogham/exa#installation) then try `ll` command on your terminal
- [ghq](https://github.com/x-motemen/ghq) - Repository Manager like Go Get
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

Note: Brew installs fish on `/opt/homebrew/bin/fish` so you might need to
symlink it on `/usr/local/bin` for it to work. e.g `sudo ln -s
/opt/homebrew/bin/fish /usr/local/bin`

## Terminal Based Config

### [Iterm2](https://iterm2.com/) + [Tmux](https://github.com/tmux/tmux/wiki)

### Tmux

Install Tmux

```
# MacOs
brew install tmux
# Ubuntu
apt install tmux
```

https://github.com/tmux/tmux/wiki/Installing

Copy `.tmux.conf` and `.tmux.conf.local` in your local directory

```
cp /path-to-dotfiles/.tmux.conf
cp /path-to-dotfiles/.tmux.conf.local .
```

Then proceed to customize your ~/.tmux.conf.local copy.

Note: You also need to install [nerd-font](https://github.com/ryanoasis/nerd-fonts) in order for icons to work

**Set FiraCode Nerd as Iterm Font**

`Iterm -> User Preferences -> Profiles`

select `Text` menu and select `FiraCode Nerd` font as preferred font

### Reattach to namespace

```
brew install reattach-to-user-namespace
```

## [Kitty](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-tab)

Copy kitty config in `~/.config` directory from your Home folder

```
ln -s /path-to-dotfiles/.config/kitty ~/.config
```

### Other Utilities

#### Git Commit Template

Set git commit template using `git config --global commit.template ~/dotfiles/.git-commit-template`

#### Starship

##### Installation

- [starship](https://starship.rs/guide/#🚀-installation) - Customizable Shell Prompt

##### Configuration

Symlink .starship.toml to your `.config` directory

```
$ cd dotfiles
$ ln -s .config/.starship.toml $HOME/.config/starship.toml
```

##### Configuration

You can check the official [guide](https://starship.rs/config/#prompt) to
configure starship if you don't want to use our default configuration :)

## Commands and Bindings

For Tmux commands you can check the official (guide)(https://github.com/gpakosz/.tmux#bindings) on which we fork our
`.tmux.conf` config

TLDR; I prefer use CTRL+A as tmux prefix :)

### Commands

This section contains available commands and their usage for each packages.

#### Fish

##### General

- `c` Alias to clear
- `s` Alias to ssh
- `cx` Alias to chmod +x
- `more` Alias to less
- `cleanup` Remove _.tmp, _.aux and \*.log files on current directory
- `cdl` Navigate to directory and list files e.g `cdl dotfiles`
- `backup` Create a backup for a file e.g `backup README.md -> README.md.bak`
- `gfind` Globally search for a file e.g `gfind README.md`
- `lfind` Locally search for a file e.g `lfind README.md`
- `mcd` Create directory and Navigate to it `mcd dotfiles`
- `vim` Open Neovim if exists and vim by default
- `reload` Reload fish config

##### Ruby on Rails

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

##### Git

- Git Flow

  - `gflfs` Alias for git flow feature start
  - `gflff` Alias for git flow feature finish
  - `gflhs` Alias for git flow hotfix start
  - `gflhf` Alias for git flow hotfix finish
  - `gflrs` Alias for git flow release start
  - `gflrf` Alias for git flow release finish

- Stash

  - `gstdu` Stash All unstaged changes
  - `gsta` Stash unstaged changes
  - `gstaa` Apply latest Stashed Changes

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
  - `gm` Alias to git merge

- Log
  - `glg` Alias to git log --stat
  - `glgp` Alias to git log --stat -p
  - `glgp` Alias to git log --graph with styles

##### Yarn

- `ys` Alias to yarn serve
- `yss` Alias to yarn serve:dev
- `ystd` Alias to yarn start:dev
- `ytu` Alias to yarn test:unit
- `yte` Alias to yarn test:e2e

##### Docker

- `docker_exec` function to access docker container using container name from docker ps
- `docker_exec_container` function to access docker container using container name as string. Use docker_exec_container -h to learn more

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
