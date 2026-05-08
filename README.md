# codex-switch

Manage multiple [Codex](https://github.com/openai/codex) accounts on a single machine.

## Setup

```bash
curl -fsSL https://raw.githubusercontent.com/byzhangkui/codex-switch/main/install.sh | sh
```

Then reload shell:

```bash
source ~/.zshrc
```

## Usage

**Save current account**

After logging in with `codex`, save the session:

```bash
codex-save work
codex-save personal
```

**Switch account**

```bash
codex-use work       # switch directly by name
codex-use            # interactive list
```

Switches `~/.codex/auth.json` to the selected account and launches `codex`.

## File structure

```
~/.config/codex-accounts/
  codex-accounts.sh    # shell functions
  accounts/            # auth files (gitignored, local only)
    work/
      auth.json
    personal/
      auth.json
```

Account data is stored locally and never committed.
