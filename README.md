# Neovim config (LazyVim + nvim-agent)

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup with an **nvim-agent** bridge so coding agents (Cursor, Codex, etc.) or a plain shell can control the focused Neovim session.

## What's included

| Path | Purpose |
|------|---------|
| `lua/config/` | LazyVim options, keymaps, autocmds |
| `lua/config/nvim-agent.lua` | Publishes RPC address for remote control |
| `bin/nvim-agent` | Agent-agnostic CLI |
| `skills/nvim-agent/` | Skill doc (same format for Cursor / Codex / …) |
| `install.sh` | Symlinks CLI + skills on a new machine |
| `lazyvim.json` | Enabled LazyVim extras |

## Fresh machine

```bash
# requires: git, Neovim 0.11+, curl
git clone git@github.com:alexxozo/nvim-config.git ~/.config/nvim
~/.config/nvim/install.sh
nvim   # first launch installs plugins
nvim-agent status
```

`install.sh` links the skill into whichever agent homes exist:

- `~/.cursor/skills/nvim-agent` (Cursor)
- `~/.codex/skills/nvim-agent` (Codex)
- `~/.agents/skills/nvim-agent` (shared agents dir, if present)

The CLI always goes to `~/.local/bin/nvim-agent`.

## Iterate on this machine

Edit under `~/.config/nvim`, commit, push. Symlinks mean one source of truth.

## nvim-agent quick ref

```bash
nvim-agent status
nvim-agent info
nvim-agent open path/to/file.py 42
nvim-agent cmd 'Gitsigns diffthis'
```

In Neovim: `:NvimAgentStatus`

## LazyVim extras (current)

- `editor.neo-tree`
- `lang.python`
- `lang.markdown`
- `lang.toml`
