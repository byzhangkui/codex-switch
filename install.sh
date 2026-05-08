#!/bin/sh
set -e

REPO="https://github.com/byzhangkui/codex-switch.git"
INSTALL_DIR="$HOME/.config/codex-accounts"
ZSHRC="$HOME/.zshrc"
SOURCE_LINE="source ~/.config/codex-accounts/codex-accounts.sh"

echo "Installing codex-switch..."

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Already installed, pulling latest..."
  git -C "$INSTALL_DIR" pull
else
  git clone "$REPO" "$INSTALL_DIR"
fi

if grep -qF "$SOURCE_LINE" "$ZSHRC" 2>/dev/null; then
  echo "~/.zshrc already configured, skipping."
else
  echo "" >> "$ZSHRC"
  echo "# Codex multi-account switcher" >> "$ZSHRC"
  echo "$SOURCE_LINE" >> "$ZSHRC"
  echo "Added source line to ~/.zshrc"
fi

echo ""
echo "Done! Run the following to activate:"
echo ""
echo "  source ~/.zshrc"
echo ""
echo "Usage:"
echo "  codex-save <name>   save current account"
echo "  codex-use [name]    switch account and launch codex"
