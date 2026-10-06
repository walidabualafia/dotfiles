---
name: dev-env-setup
description: Set up Walid's terminal dev environment from the walidabualafia/dotfiles repo (nvim + tmux configs are symlinked from it), on a new Linux account (no root, e.g. HPC) or a Mac — Neovim + NvChad, tmux 3.x + oh-my-tmux, OSC 52 clipboard over SSH/tmux, ~/.local/apps auto-discovery in .bashrc, the `copy` shell helper, and the tmux weather widget. Use when asked to "set up my environment", "install my nvim/tmux setup", or replicate this config on another machine.
---

# Dev environment setup (nvim + NvChad + tmux + clipboard)

Goal: reproduce the same setup everywhere, as simply as possible.

**Ground rules (from the user):**
- Do NOT change NvChad default keybinds (the user looks them up in docs). The
  starter's `;` → `:` and `jk` → `<Esc>` mappings are template defaults — keep them.
- Don't overengineer. Small, commented changes only.
- Ask before overwriting an existing file; back it up first (`cp f f.bak`).
- Verify each step actually works (headless nvim, throwaway tmux server) and
  report honestly.

First detect the platform: `uname -s` (Linux / Darwin), `uname -m`, whether
there's sudo/Homebrew, `nvim --version`, `tmux -V`, `echo $SHELL`, `locale`.

---

## 0. Clone the dotfiles repo

Configs live in **`walidabualafia/dotfiles`** (public) and are **symlinked**
into place, so edits on any machine are tracked in git. See its README.md
for the layout.
```sh
[ -d ~/dotfiles ] || git clone git@github.com:walidabualafia/dotfiles.git ~/dotfiles \
  || git clone https://github.com/walidabualafia/dotfiles.git ~/dotfiles   # no GitHub SSH key
git -C ~/dotfiles pull --ff-only
```
This skill itself is `~/dotfiles/claude/skills/dev-env-setup/`; install it with
`mkdir -p ~/.claude/skills && ln -s ~/dotfiles/claude/skills/dev-env-setup ~/.claude/skills/`.

**Changing configs later:** edit through the symlinks as usual, then commit
and push from `~/dotfiles` (ask before pushing). Other machines pick changes
up with `git -C ~/dotfiles pull`.

## 1. Install Neovim

**Linux (no root):** use the official prebuilt tarball in `~/.local/apps`
(it's relocatable):
```sh
mkdir -p ~/.local/apps && cd ~/.local/apps
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz   # or nvim-linux-arm64
tar xzf nvim-linux-*.tar.gz && rm nvim-linux-*.tar.gz
```
PATH is handled by the `.bashrc` loop in step 5.

**macOS:** `brew install neovim ripgrep`.

NvChad also wants `git`, `ripgrep` (`rg`, for Telescope) and a C compiler (treesitter).
The local terminal needs a **Nerd Font** (e.g. JetBrainsMono Nerd Font) or icons render as boxes.

## 2. Install the NvChad config from the dotfiles repo

If `~/.config/nvim` (or `~/.local/share/nvim`) already exists, ask, then back
it up (`mv ~/.config/nvim ~/.config/nvim.bak`).
```sh
mkdir -p ~/.config && ln -s ~/dotfiles/nvim ~/.config/nvim
```

What the config contains (for context — don't re-apply, it's already in the repo):
- NvChad starter (v2.5) with `github_dark` theme, italic comments, nvdash,
  blink.cmp (`{ import = "nvchad.blink.lazyspec" }`).
- `lua/options.lua`: `termguicolors = true` (tmux hides truecolor), and — only
  when `SSH_TTY`/`SSH_CONNECTION` is set — OSC 52 copy to the local clipboard
  with paste from nvim's own registers (OSC 52 paste stalls on most
  terminals). Locally (macOS) nvim auto-detects pbcopy.
- Do NOT re-declare `nvchad/ui`, `nvchad/base46` or `nvzone/volt` in
  `lua/plugins/init.lua` — NvChad already includes them (a duplicate `base46`
  spec with `lazy = true` was part of a past breakage).

Commit `lazy-lock.json` along with config changes so plugin versions match everywhere.

**Install plugins and build the theme cache** (the base46 build only runs on
install/update, so run it explicitly — otherwise `init.lua` errors with
`base46_cache/defaults: No such file or directory`):
```sh
nvim --headless "+Lazy! restore" +qa   # exact versions from lazy-lock.json
nvim --headless +'lua require("base46").load_all_highlights()' +qa
```
**Verify:** run headless nvim on a scratch file — no startup errors;
`yy` then `p` works; `:checkhealth vim.provider` shows "Clipboard tool found: OSC 52"
over SSH (pbcopy on macOS).

## 3. tmux 3.x

Need tmux ≥ 3.2 (emoji width, oh-my-tmux compatibility — on 2.7 its
`bind e new-window -e …` line errors, and emoji break the status bar).

**macOS:** `brew install tmux`.

**Linux with old system tmux and no root** — build into `~/.local/apps/tmux`
with libevent linked statically (needs gcc, make, ncurses-devel, bison;
check with `rpm -q`/`dpkg -l`). Check the tmux releases page for the latest version.
```sh
P=$HOME/.local/apps/tmux
cd "$(mktemp -d)"   # or the session scratchpad
curl -fsSLO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
curl -fsSLO https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
tar xzf libevent-*.tar.gz && tar xzf tmux-*.tar.gz
(cd libevent-2.1.12-stable && ./configure --prefix=$P --disable-shared --disable-openssl --disable-samples && make -j8 && make install)
(cd tmux-3.5a && PKG_CONFIG_PATH=$P/lib/pkgconfig ./configure --prefix=$P && make -j8 && make install)
rm -rf $P/lib $P/include     # build-only libevent files; keeps them off LD/LIBRARY paths
$P/bin/tmux -V
```
The user must `tmux kill-server` before switching (a new client can't talk to an old server).

## 4. oh-my-tmux (gpakosz/.tmux) + local customizations

oh-my-tmux itself comes from upstream; the customized `~/.tmux.conf.local` is
`~/dotfiles/tmux/tmux.conf.local`. Back up an existing `~/.tmux.conf.local` first (ask).
```sh
[ -d ~/.tmux ] || git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f .tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local
```

What it changes vs. the upstream template (already in the file — context only):
- **Clipboard:** `set -s set-clipboard on` at the end. The default `external`
  only lets tmux's own copy mode reach the clipboard; nvim's OSC 52 is dropped.
- **Weather:** oh-my-tmux's built-in `weather()` custom variable (lines keep
  their leading `# ` — that's how oh-my-tmux parses them), shown as
  `#{weather}` in `tmux_conf_theme_status_right` before the time:
  ```
  #   curl -f -s -m 2 'wttr.in/Memphis?format=%l:+%c%t&u'; printf '\n'
  ```
  - `; printf '\n'` is required: this format has no trailing newline, and tmux
    won't show a job's output until a full line arrives (the function then
    sleeps 15 min, so it would stay "not ready" forever).
  - `%c` is an emoji — needs tmux ≥ 3.2; on older tmux switch to `%C` (text).
  - `&u` = Fahrenheit. City is hardcoded `Memphis`; if the user wants another,
    edit it in the repo file. It can't be auto-detected: the request comes
    from the server, and SSH client IPs are usually internal/VPN.
  - Never call wttr.in directly in `status-right` with a short
    `status-interval` — that hammered the API every 5s and broke tmux before.

**Verify** with a throwaway server (doesn't touch the user's sessions):
```sh
tmux -L test -f ~/.tmux.conf new -d \; show -s set-clipboard \; kill-server
```
To see the rendered status bar, attach a real client under `script` for ~15s
and grep the output for `°F` (`display -p` alone doesn't run status jobs).

**Locale gotcha:** if status-bar symbols (❐ ↑ ⌨) show as `_` or vanish, the
shell starting tmux has a non-UTF-8 locale (seen on HPC: `LC_ALL=C`). Fix with
`alias tmux='tmux -u'` (or set `LC_ALL=en_US.UTF-8`) — offer, don't assume.

## 5. `.bashrc` (Linux)

Back up `~/.bashrc` first. Add these if missing (don't duplicate).

**`~/.local/apps` auto-discovery** — every `~/.local/apps/<name>/{bin,lib,…}` is
added to the right paths, so new apps need no `.bashrc` edits. Only install
relocatable builds there, or ones built with `--prefix=$HOME/.local/apps/<name>`
(source-built apps like vim/tmux hardcode their prefix — don't move them).
```bash
# Apps in ~/.local/apps/<name>/{bin,lib,lib64,include,share/man,...}
# Prepend VAR with DIR if DIR exists and isn't already in VAR (safe to re-source).
_apps_prepend() {
  local var=$1 dir=$2
  [ -d "$dir" ] || return 0
  case ":${!var}:" in *":$dir:"*) return 0 ;; esac
  if [ -n "${!var}" ]; then
    export "$var=$dir:${!var}"
  elif [ "$var" = MANPATH ]; then
    export "$var=$dir:"   # trailing colon keeps man's default search path
  else
    export "$var=$dir"
  fi
}
: "${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
for _app in "$HOME"/.local/apps/*/; do
  _app=${_app%/}
  _apps_prepend PATH              "$_app/bin"
  _apps_prepend CMAKE_PREFIX_PATH "$_app"
  _apps_prepend CPATH             "$_app/include"
  _apps_prepend XDG_DATA_DIRS     "$_app/share"
  _apps_prepend MANPATH           "$_app/share/man"
  _apps_prepend MANPATH           "$_app/man"
  for _lib in lib lib64; do
    _apps_prepend LD_LIBRARY_PATH "$_app/$_lib"
    _apps_prepend LIBRARY_PATH    "$_app/$_lib"
    _apps_prepend PKG_CONFIG_PATH "$_app/$_lib/pkgconfig"
  done
  _apps_prepend PKG_CONFIG_PATH   "$_app/share/pkgconfig"
done
export XDG_DATA_DIRS
unset _app _lib
```

**`copy` helper** — send text from the remote shell to the local clipboard
(OSC 52; works inside tmux thanks to `set-clipboard on`):
```bash
# Usage: copy "text" | copy some words | cmd | copy | copy < file
copy() {
  local data
  if [ $# -gt 0 ]; then
    data=$(printf "%s" "$*" | base64 | tr -d '\n')
  else
    data=$(base64 | tr -d '\n')
  fi
  # \033]52;c;<base64>\a
  printf "\e]52;c;%s\a" "$data"
}
```

Optionally suggest `export EDITOR=nvim`.

**Verify** in a clean login shell:
`env -i HOME=$HOME TERM=xterm bash -ic 'type -P nvim tmux; tmux -V'`.

## 6. macOS (local machine) differences

- Use Homebrew for nvim/tmux/ripgrep; skip the `~/.local/apps` loop and tmux build.
- Default shell is **zsh** → config goes in `~/.zshrc`. The `_apps_prepend`
  loop uses bash-only `${!var}`, so don't paste it into zsh.
- `copy` isn't needed locally (`pbcopy` exists). If wanted, it works in zsh as-is.
- The nvim clipboard block is skipped automatically (no SSH vars) → nvim uses pbcopy.
- oh-my-tmux + `~/.tmux.conf.local` steps are identical (`set-clipboard on`
  is harmless locally and needed when SSHing out of local tmux).
- **The Mac's terminal is what makes remote OSC 52 copying work.** Recommend
  iTerm2 (enable *Settings → General → Selection → "Applications in terminal
  may access clipboard"*), Ghostty, WezTerm or kitty. Older Terminal.app
  doesn't support OSC 52 or truecolor. Install a Nerd Font and select it in
  the terminal.

## Final checklist to report back
- `nvim` starts with no errors; theme renders; `yy` reaches the local clipboard
  (over SSH, inside and outside tmux).
- `tmux -V` ≥ 3.2; `tmux show -s set-clipboard` → `on`; status bar shows the weather.
- New shell finds the right `nvim`/`tmux` (`type -P`).
- List every file changed and every backup made.
