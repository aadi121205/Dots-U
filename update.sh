#!/usr/bin/env bash
# update.sh — pull live configs back into the repo, then commit
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Syncing live configs into $REPO"
echo ""

echo "[fish]"
cp "$HOME/.config/fish/config.fish"  "$REPO/config/fish/config.fish"
cp "$HOME/.config/fish/fish_plugins" "$REPO/config/fish/fish_plugins" 2>/dev/null || true
rsync -a --delete --exclude='fish_variables*' \
    "$HOME/.config/fish/functions/"    "$REPO/config/fish/functions/"
rsync -a --delete \
    "$HOME/.config/fish/completions/"  "$REPO/config/fish/completions/"
rsync -a --delete \
    "$HOME/.config/fish/conf.d/"       "$REPO/config/fish/conf.d/"
rsync -a --delete \
    "$HOME/.config/fish/themes/"       "$REPO/config/fish/themes/"

echo "[nvim]"
rsync -a --delete \
    --exclude='lazy-lock.json' \
    "$HOME/.config/nvim/" "$REPO/config/nvim/"

echo "[kitty]"
cp "$HOME/.config/kitty/kitty.conf"  "$REPO/config/kitty/kitty.conf"

echo "[btop]"
cp "$HOME/.config/btop/btop.conf"    "$REPO/config/btop/btop.conf"

echo "[git]"
cp "$HOME/.config/git/ignore"        "$REPO/config/git/ignore"
cp "$HOME/.gitconfig"                "$REPO/home/.gitconfig"

echo "[tmux]"
cp "$HOME/.tmux.conf"                "$REPO/home/.tmux.conf"

echo "[shell]"
cp "$HOME/.bashrc"                   "$REPO/home/.bashrc"
cp "$HOME/.profile"                  "$REPO/home/.profile"

echo "[gnome]"
dconf dump /org/gnome/shell/extensions/ > "$REPO/gnome/dconf/extensions.dconf"
dconf dump /org/gnome/shell/           > "$REPO/gnome/dconf/shell.dconf"
dconf dump /org/gnome/desktop/         > "$REPO/gnome/dconf/desktop.dconf"
dconf dump /org/gnome/mutter/          > "$REPO/gnome/dconf/mutter.dconf"
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > "$REPO/gnome/dconf/keybindings.dconf"
gnome-extensions list --user > "$REPO/gnome/extensions.txt"

echo ""
echo "==> Sync complete. Staging changes..."
cd "$REPO"
git add -A

if git diff --cached --quiet; then
    echo "    Nothing changed."
else
    git status --short
    echo ""
    read -rp "Commit message (leave blank to skip commit): " msg
    if [[ -n "$msg" ]]; then
        git commit -m "$msg"
        echo "    Committed."
    else
        echo "    Changes staged but not committed."
    fi
fi
