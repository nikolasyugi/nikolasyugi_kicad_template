#!/usr/bin/env bash
set -euo pipefail

# Configuration (edit here or export env vars before running)
REPO_PATH="/Users/nikolasyugi/Documents/projects/nikolasyugi_kicad_template"
KICAD_TEMPLATE_DIR="~/Documents/KiCad/9.0/template"

# Expand leading ~ to $HOME if present
if [[ "$KICAD_TEMPLATE_DIR" == ~* ]]; then
  KICAD_TEMPLATE_DIR="${KICAD_TEMPLATE_DIR/#~/$HOME}"
fi
if [[ "$REPO_PATH" == ~* ]]; then
  REPO_PATH="${REPO_PATH/#~/$HOME}"
fi

LINK_NAME="$(basename "$REPO_PATH")"
DEST="$KICAD_TEMPLATE_DIR/$LINK_NAME"

usage() {
  cat <<EOF
Usage: $0 [install|remove|status]

Commands:
  install   Create (or replace) the symlink in the KiCad templates folder
  remove    Remove the symlink (only if it's a symlink)
  status    Show current link and targets

You can override defaults by exporting REPO_PATH or KICAD_TEMPLATE_DIR, e.g.:
  REPO_PATH=~/dev/my-template KICAD_TEMPLATE_DIR=~/Documents/KiCad/9.0/template $0 install
EOF
  exit 1
}

cmd="${1:-install}"

case "$cmd" in
  install)
    echo "Creating templates directory: $KICAD_TEMPLATE_DIR"
    mkdir -p "$KICAD_TEMPLATE_DIR"

    echo "Link name: $LINK_NAME"
    echo "Creating symlink: $DEST -> $REPO_PATH"
    ln -sfn "$REPO_PATH" "$DEST"
    echo "Symlink created."
    ;;

  remove|unlink)
    if [ -L "$DEST" ]; then
      echo "Removing symlink: $DEST"
      rm "$DEST"
      echo "Removed."
    else
      echo "No symlink found at: $DEST"
      exit 1
    fi
    ;;

  status)
    echo "REPO_PATH=$REPO_PATH"
    echo "KICAD_TEMPLATE_DIR=$KICAD_TEMPLATE_DIR"
    echo "DEST=$DEST"
    ls -ld "$DEST" || true
    ;; 

  *)
    usage
    ;;
esac

exit 0
