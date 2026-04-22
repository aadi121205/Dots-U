#!/usr/bin/env bash
# install.sh — symlink dots from this repo into the live system
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

backup_and_link() {
    local src="$1"   # file/dir in repo
    local dst="$2"   # destination in $HOME

    mkdir -p "$(dirname "$dst")"

    # Back up existing target if it's a real file/dir (not already our symlink)
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        mkdir -p "$BACKUP"
        cp -r "$dst" "$BACKUP/"
        echo "  backed up $dst"
    fi

    # Remove old symlink or file, then link
    rm -rf "$dst"
    ln -s "$src" "$dst"
    echo "  linked $dst -> $src"
}

echo "==> Installing dotfiles from $REPO"
echo ""

echo "[fish]"
backup_and_link "$REPO/config/fish/config.fish"    "$HOME/.config/fish/config.fish"
backup_and_link "$REPO/config/fish/fish_plugins"   "$HOME/.config/fish/fish_plugins"
backup_and_link "$REPO/config/fish/functions"      "$HOME/.config/fish/functions"
backup_and_link "$REPO/config/fish/completions"    "$HOME/.config/fish/completions"
backup_and_link "$REPO/config/fish/conf.d"         "$HOME/.config/fish/conf.d"
backup_and_link "$REPO/config/fish/themes"         "$HOME/.config/fish/themes"

echo "[nvim]"
backup_and_link "$REPO/config/nvim"    "$HOME/.config/nvim"

echo "[kitty]"
backup_and_link "$REPO/config/kitty/kitty.conf"   "$HOME/.config/kitty/kitty.conf"

echo "[btop]"
backup_and_link "$REPO/config/btop/btop.conf"     "$HOME/.config/btop/btop.conf"

echo "[git]"
backup_and_link "$REPO/config/git/ignore"         "$HOME/.config/git/ignore"
backup_and_link "$REPO/home/.gitconfig"           "$HOME/.gitconfig"

echo "[tmux]"
backup_and_link "$REPO/home/.tmux.conf"  "$HOME/.tmux.conf"

echo "[shell]"
backup_and_link "$REPO/home/.bashrc"    "$HOME/.bashrc"
backup_and_link "$REPO/home/.profile"   "$HOME/.profile"

echo "[gnome]"
dconf load /org/gnome/shell/extensions/ < "$REPO/gnome/dconf/extensions.dconf"
echo "  loaded extension settings"
dconf load /org/gnome/shell/           < "$REPO/gnome/dconf/shell.dconf"
echo "  loaded shell settings"
dconf load /org/gnome/desktop/         < "$REPO/gnome/dconf/desktop.dconf"
echo "  loaded desktop settings"
dconf load /org/gnome/mutter/          < "$REPO/gnome/dconf/mutter.dconf"
echo "  loaded mutter settings"
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$REPO/gnome/dconf/keybindings.dconf"
echo "  loaded keybindings"
echo "  NOTE: install extensions manually via Extension Manager or the URLs in README"

echo ""
echo "==> Done."
[[ -d "$BACKUP" ]] && echo "    Backups saved to: $BACKUP"
