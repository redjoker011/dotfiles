# Fish Shell Commands & Bindings Reference

This section contains available abbreviations, aliases, and their usages. Most aliases have been migrated to native Fish **Abbreviations (`abbr`)** which expand interactively on screen when pressing Space.

## Commands

### General
- `c` Clear terminal
- `s` SSH command
- `cx` Quick `chmod +x`
- `more` Redirects to modern `less` pager
- `cleanup` Remove `*.tmp`, `*.aux` and `*.log` files on current directory
- `reload` Reliably reload your `config.fish` profile environment

### Ruby on Rails
- `ber` Run `bundle exec rake`
- `rs` Smart Rails Server script (Gracefully stops Spring binstub if active before booting)
- `rc` Smart Rails Console script (Gracefully stops Spring binstub if active before booting)
- `bs` Run `bundle exec sidekiq`

### Git
- **Stash**
  - `gstaa` Apply the most recent snapshot inside the stash layout

- **Branch**
  - `gb` View existing local tracking branches
  - `gba` Display all available remote/local branch configurations
  - `gbx` Nuke all local git tracking branches excluding `main`, `master`, and `development`

- **Commit**
  - `ga` Stage selective changes (`git add`)
  - `gaa` Stage all changes across the working tree (`git add --all`)
  - `gst` Inquire current tracking layouts (`git status`)
  - `gcp` Pluck adjustments using `git cherry-pick`
  - `gc` Open verbose interface to execute a commit (`git commit -v`)
  - `gcf` Force pass structural lint constraints bypassing hook frameworks (`Overcommit`/`Husky`)

- **Checkout**
  - `gcm` Seamlessly check out to the dominant main branch layout (Evaluates `main`, `trunk`, or `master`)
  - `gcd` Target `development` branch environment
  - `gcds` Target short-named `dev` branch environment
  - `gcb` Generate and target a fresh local workspace branch configuration
  - `gco` Regular checkout command interface

- **Pull / Push**
  - `ggpur` Dynamic pull-rebase on your current origin matching tracking branch
  - `ggpull` Safely request and sync adjustments from current origin branch
  - `ggpush` Ship active local modifications upstream to current origin branch
  - `ggpuru` Pull and rebase tracking modifications from the tracking **upstream** branch
  - `ggpullu` Acquire and merge raw adjustments from the tracking **upstream** branch
  - `ggpushu` Publish changes straight to the designated **upstream** repository tracking path
  - `gpsup` Publish a fresh tracking branch directly mapping upstream to origin configurations on initial push

- **History**
  - `gbl` Run robust tracking annotations (`git blame -b -w`)
  - `grb` Rebase against targeted configurations
  - `grba` Abort current rebase sequence cleanly
  - `grbc` Forward adjustments following structural corrections (`git rebase --continue`)
  - `grbi` Execute interactive timeline cleanups (`git rebase -i`)
  - `gm` Standard merge pipeline controls

- **Log**
  - `glg` Standard commit logs with summarized file stats
  - `glgp` Expanded log tracking including inline patch comparisons
  - `glods` Structured colored layout showing graph history maps on your active branch

### Docker
- `dsprune` Drastically free up computing disk footprint by stripping out unused Docker containers, network contexts, volumes, and cached imagery structures.
- `dcb` Execute build instructions with appended args via `docker compose build`
- `dcup` Orchestrate system initialization via `docker compose up`
- `dcstop` Bring down containers gracefully via `docker compose stop`

## Bindings

### Eza (LS Replacement)
- `ll` Render directory tree views cleanly detailing files complete with permissions, metadata sizes, context colors, and Nerd Font descriptive icons.

### FZF-Fish (PatrickF1/fzf.fish Engine)
Modern configurations leverage the non-conflicting ergonomic `Ctrl+Alt` combination parameters natively mapped by the engine framework:

* `Ctrl+Alt+F` : Query file paths and structures (complemented by live `bat` syntax tracking syntax windows)
* `Ctrl+Alt+S` : Explore altered file targets using an interactive `delta` diff layout frame
* `Ctrl+Alt+L` : Explore, parse, and skim over sequential commit timeline files
* `Ctrl+Alt+P` : Interactively locate active system ports and kill structural process IDs
* `Ctrl+G` : Fuzzy find historical terminal runtime history logs
* `Ctrl+V` : Query and inspect internal active shell runtime variable states
* `Ctrl+X` : Interactive Git Diff
