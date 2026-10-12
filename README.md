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
git clone git@github.com:alexxozo/nvim-config.git ~/.config/nvim
~/.config/nvim/install.sh
nvim
nvim-agent status
```

For Handy FN → Herdr agent routing, use the separate project:

**https://github.com/alexxozo/handy-herdr**

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
