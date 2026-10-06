# dotfiles

My terminal setup — Neovim (NvChad) and tmux (oh-my-tmux) — tuned for working
over SSH on HPC clusters, inside tmux, with copy/paste reaching my local
clipboard. Plus cool dotfiles I've found and collected over the years (not
all of them are my own, but most are).

## What's in here

**Active setup:** what I use day to day, installed by symlink:

| Path | What it is | Installed to |
|---|---|---|
| `nvim/` | NvChad config (starter + my customizations) | `~/.config/nvim` |
| `tmux/tmux.conf.local` | My oh-my-tmux customizations | `~/.tmux.conf.local` |
| `claude/skills/dev-env-setup/` | Claude Code skill that sets all of this up on a new machine | `~/.claude/skills/dev-env-setup` |

Because these are symlinked from the repo, editing them in place edits the
repo: commit and push here, then `git pull` on other machines.

**Collection:** older and alternative configs, kept for reference and
copied by hand when needed. They're [described below](#the-collection).

## Quick setup

The easiest way: install the Claude Code skill and ask Claude to do the rest.
It handles Linux without root, macOS, existing configs, and checks that
everything works:

```sh
git clone git@github.com:walidabualafia/dotfiles.git ~/dotfiles
mkdir -p ~/.claude/skills && ln -s ~/dotfiles/claude/skills/dev-env-setup ~/.claude/skills/
```
Then in Claude Code: *"set up my dev environment"* (or `/dev-env-setup`).

Besides linking these configs, the skill also covers installing Neovim and
tmux without root, the `~/.local/apps` PATH setup and `copy` helper for
`.bashrc`, and macOS differences.

### Manual setup

Requirements: Neovim ≥ 0.11, tmux ≥ 3.2, git, curl, ripgrep, a C compiler,
and a [Nerd Font](https://www.nerdfonts.com/) in your local terminal.

Back up any existing `~/.config/nvim` and `~/.tmux.conf.local` first.

```sh
git clone git@github.com:walidabualafia/dotfiles.git ~/dotfiles

# Neovim
ln -s ~/dotfiles/nvim ~/.config/nvim
nvim --headless "+Lazy! restore" +qa                                # pinned plugin versions
nvim --headless +'lua require("base46").load_all_highlights()' +qa  # build theme cache

# tmux (oh-my-tmux from upstream + my local overrides)
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f .tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local
```

## Customizations

### Neovim (`nvim/`)

NvChad v2.5 with default keybinds, so the NvChad docs apply as-is.

- `github_dark` theme (toggle to `github_light`), italic comments, dashboard on start
- blink.cmp for completion
- Truecolor forced on, since tmux hides it from Neovim's auto-detection
- **Over SSH**, yanks go to your *local* clipboard via OSC 52. Pasting with `p`
  uses Neovim's own registers; to paste from your local clipboard, use your
  terminal's paste shortcut. Locally (e.g. macOS) Neovim uses the system
  clipboard as normal.

### tmux (`tmux/tmux.conf.local`)

The stock oh-my-tmux template plus:

- `set -s set-clipboard on`, so programs inside tmux (like Neovim) can reach
  your local clipboard
- A weather widget in the status bar (`Memphis: ☀️ +77°F`, from
  [wttr.in](https://wttr.in), refreshed every 15 minutes). To change the city,
  edit the `wttr.in/Memphis` line in the file.

## The collection

To use one of these, copy it into place (e.g. `cp vim/main.vimrc ~/.vimrc`)
and install whatever plugin manager it uses.

### `vim/`

Vim configs unless noted, by plugin manager and completion engine:

| File | Plugin manager | Completion | Notes |
|---|---|---|---|
| `main.vimrc` | Vundle | YouCompleteMe | My main Vim config (v1.0, 2023): srcery theme, auto-format on save (`F3` to format), Go/Racket/LaTeX/emmet support |
| `vimproved.vimrc` | vim-plug | YouCompleteMe | Like `main.vimrc` on vim-plug, with vim-airline |
| `coc.vimrc` | vim-plug | coc.nvim | `vimproved.vimrc` with YCM swapped for CoC, plus CoC's standard keymaps |
| `coc.cluster.code.vimrc` | vim-plug | coc.nvim | **Neovim** variant of `coc.vimrc` for the cluster (v1.1, 2024) |
| `turing.vimrc` | vim-plug | — | Lightweight config for the "turing" machine (v1.1, 2025): gruvbox, custom statusline, cursorline flash on search |
| `plugged.vimrc` | vim-plug | — | **Neovim** config (`~/.config/nvim/plugged`) with vim-airline and srcery |
| `vundle.vimrc` | Vundle | YouCompleteMe | Plugin-heavy: fugitive, commentary, surround, syntastic, airline, rainbow brackets |
| `cool.vimrc` | Vundle | YouCompleteMe | gruvbox + truecolor ([iTerm/tmux/Vim truecolor guide](https://tomlankhorst.nl/iterm-tmux-vim-true-color/)) |
| `minor.vimrc` | Vundle | YouCompleteMe | Like `cool.vimrc` with the srcery theme |
| `ubuntu.vimrc` | Vundle | YouCompleteMe | Like `cool.vimrc`, used on Ubuntu |

### `tmux/`

| File | Notes |
|---|---|
| `oh-my.tmux.conf` | An older customized [oh-my-tmux](https://github.com/gpakosz/.tmux) local config: Powerline separators and a wttr.in weather widget that calls the API on every status refresh (replaced by `tmux.conf.local`) |
| `tpm.tmux.conf` | Small config using [TPM](https://github.com/tmux-plugins/tpm): `C-a` prefix, vim-style `hjkl` pane movement, tmux-themepack Powerline theme |
| `hardcore.tmux.conf` | No plugins: a dump of tmux's default options plus vi copy mode, `C-a` prefix, `Alt`+arrows to switch panes, `prefix r` to reload |

### `bash/`

| File | Platform | Notes |
|---|---|---|
| `clean-shared.bashrc` | Linux cluster | Standard RHEL-style `.bashrc`: colored prompt, history settings, `ls`/`grep` colors, `sq` = `squeue` (Slurm) |
| `lotus.bashrc` | Linux cluster | Identical to `clean-shared.bashrc` |
| `godspeed.bashrc` | Linux cluster | Lmod, spack and Neovim from `~/.local/apps`, `vim` = `nvim`, `tmux -u` |
| `colorful-debian.bashrc` | Linux / macOS | Tiny Debian-style `[user@host: cwd]$` colored prompt, with a macOS section |
| `personal.bashrc` | macOS | Colored prompt, Java, Google Cloud SDK, Anaconda |
| `modular.bash_profile` | macOS | Prompt switcher aliases (`linux`, `beautify` = oh-my-bash, `powerline`, `sexy`), plus Go, Racket, Ruby (chruby), Homebrew completion, iTerm2 integration |

### `misc/`

| File | Notes |
|---|---|
| `synth-shell-greeter.config` | Config for the [synth-shell](https://github.com/andresgongora/synth-shell) login greeter: custom logo, system info and resource bars. It shows your local *and public* IP at login |
| `themes/robbyrussell.theme.sh` | [oh-my-bash](https://github.com/ohmybash/oh-my-bash) port of oh-my-zsh's [robbyrussell](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme) theme, with the hostname added |

## Tips

- **Clipboard over SSH** needs a local terminal that supports OSC 52: iTerm2
  (enable *Settings → General → Selection → Applications in terminal may
  access clipboard*), Ghostty, WezTerm, kitty or Windows Terminal.
- **Symbols missing from the tmux status bar?** Your locale isn't UTF-8 (on
  clusters, `LC_ALL=C` is common). Start tmux with `tmux -u`.
- **Upgraded tmux but nothing changed?** Run `tmux kill-server` once; a new
  client can't talk to an old server.
