#!/usr/bin/env bash
set -euo pipefail

# Directories to manage (XDG defaults)
DIRS=(
  "$HOME/.config/nvim"
  "$HOME/.local/share/nvim"
  "$HOME/.local/state/nvim"
  "$HOME/.cache/nvim"
)

usage() {
  cat <<EOF
Usage: $(basename "$0") <mode>

Modes:
  reinstall   Backup existing AstroNvim config & data, then install fresh.
  delete      Permanently delete all AstroNvim config & data.

Examples:
  $(basename "$0") reinstall
  $(basename "$0") delete
EOF
  exit 1
}

if [ $# -ne 1 ]; then
  usage
fi

MODE=$1

case $MODE in
  reinstall)
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_DIR="$HOME/astronvim_backup_$TIMESTAMP"
    echo "🔒 Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$BACKUP_DIR/share"
    mkdir -p "$BACKUP_DIR/state"

    mv "$HOME/.config/nvim" "$BACKUP_DIR"
    mv "$HOME/.local/share/nvim" "$BACKUP_DIR/share"
    mv "$HOME/.local/state/nvim" "$BACKUP_DIR/state"

    echo "✨ Cloning fresh AstroNvim into ~/.config/nvim"
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
    rm -rf ~/.config/nvim/.git

    echo "📥 Restoring custom settings..."
    rm -rf ~/.config/nvim/lua/user
    # Clone your user-config repo directly
    # git clone https://github.com/joseananio/astronvim_config.git ~/.config/nvim/lua/plugins/user
    ln -sfn "$BACKUP_DIR/nvim/lua/plugins/user" ~/.config/nvim/lua/plugins/user

    # Bootstrap plugin & Mason package installation headlessly
    # echo "🔧 Installing plugins & Mason packages (headless)…"
    # nvim --headless \
    #   -c 'autocmd User AstroStartPost lua require("lazy").sync()' \
    #   -c 'MasonInstallAll' \
    #   -c 'qall' # exit headless nvim

    echo "Launching nvim to continue setup"
    nvim
    ;;

  delete)
    echo "🗑  Deleting AstroNvim directories..."
    for d in "${DIRS[@]}"; do
      if [ -d "$d" ]; then
        echo "🔨 Removing $d"
        rm -rf "$d"
      else
        echo "✅ Not found, skipping: $d"
      fi
    done
    echo "🎉 Delete complete."
    ;;

  *)
    echo "❗ Unknown mode: $MODE"
    usage
    ;;
esac

exit 0
