#!/usr/bin/env bash
# astro-bootstrap.sh  — backup / reinstall / delete AstroNvim data
# Usage:
#   ./astro-bootstrap.sh reinstall <path-to-user-config>
#   ./astro-bootstrap.sh delete
set -euo pipefail

# AstroNvim’s XDG paths ────────────────────────────────────────────────
CFG="$HOME/.config/nvim"
SHARE="$HOME/.local/share/nvim"
STATE="$HOME/.local/state/nvim"
CACHE="$HOME/.cache/nvim"
DIRS=("$CFG" "$SHARE" "$STATE" "$CACHE")

print_usage() {
  cat <<EOF
Usage:
  $(basename "$0") reinstall <user-config-dir>
  $(basename "$0") delete

Modes:
  reinstall   ▸ Back up existing AstroNvim dirs and install fresh template,
                then copy your user config into lua/plugins, lua/community.lua, etc.
  delete      ▸ PERMANENTLY delete all AstroNvim directories (config, share,
                state, cache).

Examples:
  $(basename "$0") reinstall ~/projects/my_nvim
  $(basename "$0") delete
EOF
  exit 1
}

# ─── Argument parsing ──────────────────────────────────────────────────
if (( $# < 1 )); then print_usage; fi
MODE=$1
SRC=${2:-}           # optional user config dir only needed for “reinstall”

# ─── Helper: timestamped backup dir ────────────────────────────────────
make_backup_dir() {
  local ts; ts=$(date +%Y%m%d_%H%M%S)
  local dir="$HOME/astronvim_backup_${ts}"
  mkdir -p "$dir"
  echo "$dir"
}

# ─── MAIN ──────────────────────────────────────────────────────────────
case "$MODE" in
  reinstall)
    # Sanity-check user config path
    if [[ -z "$SRC" ]]; then
      echo "❌  Missing <user-config-dir> argument for reinstall."
      print_usage
    fi
    if [[ ! -d "$SRC" ]]; then
      echo "❌  '$SRC' is not a directory."
      exit 1
    fi

    # 1. Back-up existing installation ---------------------------------
    BACKUP_DIR=$(make_backup_dir)
    echo "🔒  Backing up existing AstroNvim to: $BACKUP_DIR"
    for d in "${DIRS[@]}"; do
      if [[ -e "$d" ]]; then
        mv "$d" "$BACKUP_DIR"/
      fi
    done

    # 2. Fresh AstroNvim template --------------------------------------
    echo "✨  Cloning fresh AstroNvim into $CFG"
    git clone --depth 1 https://github.com/AstroNvim/template "$CFG"
    rm -rf "$CFG/.git"

    # 3. Copy user overrides -------------------------------------------
    echo "📥  Installing your config from '$SRC'..."
    mkdir -p "$CFG/lua/old"
    # move sample files aside (if present)
    for f in "$CFG"/lua/plugins "$CFG"/lua/community.lua; do
      [[ -e "$f" ]] && mv "$f" "$CFG/lua/old/"
    done
    # copy your own files
    cp -a "$SRC"/{plugins,community.lua,init.lua,polish.lua} "$CFG/lua/" 2>/dev/null || true

    # 4. (Optional) Headless sync --------------------------------------
    # echo "🔧  Bootstrapping plugins (headless)…"
    # nvim --headless +'AstroUpdate' +'qall'

    echo "🚀  Launching Neovim…"
    nvim
    ;;

  delete)
    echo "🗑   Deleting AstroNvim directories:"
    for d in "${DIRS[@]}"; do
      if [[ -d "$d" ]]; then
        echo "  ‣ rm -rf $d"
        rm -rf "$d"
      else
        echo "  ‣ (not found) $d"
      fi
    done
    echo "✅  Delete complete."
    ;;

  *)
    echo "❗  Unknown mode: $MODE"
    print_usage
    ;;
esacxit 0
