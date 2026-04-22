# Dots-U

Ubuntu dotfiles — Aaditya Bhatia

## What's in here

| Path in repo | Maps to |
|---|---|
| `config/fish/` | `~/.config/fish/` |
| `config/nvim/` | `~/.config/nvim/` |
| `config/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `config/btop/btop.conf` | `~/.config/btop/btop.conf` |
| `config/git/ignore` | `~/.config/git/ignore` |
| `home/.gitconfig` | `~/.gitconfig` |
| `home/.tmux.conf` | `~/.tmux.conf` |
| `home/.bashrc` | `~/.bashrc` |
| `home/.profile` | `~/.profile` |
| `gnome/dconf/extensions.dconf` | dconf `/org/gnome/shell/extensions/` |
| `gnome/dconf/shell.dconf` | dconf `/org/gnome/shell/` |
| `gnome/dconf/desktop.dconf` | dconf `/org/gnome/desktop/` |
| `gnome/dconf/mutter.dconf` | dconf `/org/gnome/mutter/` |
| `gnome/dconf/keybindings.dconf` | dconf `/org/gnome/settings-daemon/plugins/media-keys/` |
| `gnome/extensions.txt` | list of user-installed extensions |

**Stack:** Fish + Tide prompt · LazyVim · Kitty · tmux (Catppuccin-ish theme) · btop  
**GNOME extensions:** blur-my-shell · openbar · dash-to-dock · caffeine · mediacontrols · search-light · astra-monitor · tilingshell · gsconnect

## Fresh install

```bash
git clone https://github.com/aadi/Dots-U.git ~/Projects/Dots-U
cd ~/Projects/Dots-U
bash install.sh
```

`install.sh` creates symlinks from the repo into the right locations. Any existing file is backed up to `~/.dotfiles-backup-<timestamp>` before being replaced.

### After installing fish config

Restart fish, then install plugins via Fisher:

```bash
fish -c "fisher update"
```

### After installing nvim config

Open nvim — Lazy.nvim will auto-install all plugins on first launch.

### After installing GNOME settings

`install.sh` loads all dconf settings automatically. Extensions themselves still need to be installed — use **Extension Manager** (GUI) or install each one from [extensions.gnome.org](https://extensions.gnome.org).

Extensions to install (see `gnome/extensions.txt`):

| Extension | ID |
|---|---|
| Blur my Shell | `blur-my-shell@aunetx` |
| OpenBar | `openbar@neuromorph` |
| Dash to Dock | `dash-to-dock@micxgx.gmail.com` |
| Caffeine | `caffeine@patapon.info` |
| Media Controls | `mediacontrols@cliffniff.github.com` |
| Search Light | `search-light@icedman.github.com` |
| Astra Monitor | `monitor@astraext.github.io` |
| Tiling Shell | `tilingshell@ferrarodomenico.com` |
| GSConnect | `gsconnect@andyholmes.github.io` |

> **Custom keybindings** (Ctrl+Alt+B = btop, Ctrl+Alt+V = nvim, Ctrl+Alt+C = claude, Super+C = center-window) are restored automatically by `install.sh` via dconf.

## Updating the repo from your live system

Run this any time you've tweaked a config and want to save it:

```bash
bash ~/Projects/Dots-U/update.sh
```

It rsyncs everything back into the repo, shows you a diff, and offers to commit.

## Manual git workflow

```bash
cd ~/Projects/Dots-U

# See what changed
git status
git diff

# Stage and commit
git add -A
git commit -m "your message"

# Push
git push
```

## Prerequisites on a new machine

```bash
# Fish shell
sudo apt install fish
chsh -s $(which fish)

# Fisher (fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Neovim (>= 0.10)
sudo snap install nvim --classic

# Kitty
sudo apt install kitty

# btop
sudo apt install btop

# tmux
sudo apt install tmux

# Nerd Font (for prompts/nvim icons) — JetBrainsMono Nerd Font
# Download from https://www.nerdfonts.com and place in ~/.fonts/
fc-cache -fv
```
