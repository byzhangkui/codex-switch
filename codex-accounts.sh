#!/usr/bin/env zsh
# Codex multi-account switcher
# Usage:
#   codex-save <name>   save current ~/.codex/auth.json as a named account
#   codex-use [name]    switch to a named account and launch codex

_CODEX_ACCOUNTS_DIR="${0:A:h}/accounts"

codex-save() {
  local name="$1"
  if [[ -z "$name" ]]; then
    echo "Usage: codex-save <name>"
    return 1
  fi
  if [[ ! -f "$HOME/.codex/auth.json" ]]; then
    echo "Error: ~/.codex/auth.json not found"
    return 1
  fi
  mkdir -p "$_CODEX_ACCOUNTS_DIR/$name"
  cp "$HOME/.codex/auth.json" "$_CODEX_ACCOUNTS_DIR/$name/auth.json"
  echo "Saved: $name"
}

codex-use() {
  local name="$1"

  if [[ -z "$name" ]]; then
    local accounts=($(ls "$_CODEX_ACCOUNTS_DIR" 2>/dev/null))
    if [[ ${#accounts[@]} -eq 0 ]]; then
      echo "No accounts saved. Run: codex-save <name>"
      return 1
    fi
    echo "Available accounts:"
    for i in {1..${#accounts[@]}}; do
      echo "  $i. ${accounts[$i]}"
    done
    printf "Select [1-${#accounts[@]}]: "
    read sel
    name="${accounts[$sel]}"
  fi

  local src="$_CODEX_ACCOUNTS_DIR/$name/auth.json"
  if [[ ! -f "$src" ]]; then
    echo "Account not found: $name"
    return 1
  fi

  cp "$src" "$HOME/.codex/auth.json"
  echo "Switched to: $name"
  codex
}
