# Neovim config (LazyVim + nvim-agent)

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup with an **nvim-agent** bridge so Cursor (or any shell) can control the focused Neovim session.

## What's included

| Path | Purpose |
|------|---------|
| `lua/config/` | LazyVim options, keymaps, autocmds |
| `lua/config/nvim-agent.lua` | Publishes RPC address for remote control |
| `bin/nvim-agent` | CLI used by agents / you |
| `skills/nvim-agent/` | Cursor Agent Skill |
| `install.sh` | Symlinks CLI + skill on a new machine |
| `lazyvim.json` | Enabled LazyVim extras |

## Fresh machine

```bash
# requires: git, Neovim 0.11+, curl (LazyVim bootstrap)
git clone <THIS_REPO_URL> ~/.config/nvim
~/.config/nvim/install.sh
nvim   # first launch installs plugins
nvim-agent status
```

## Iterate on this machine

Edit files under `~/.config/nvim`, commit, push. The CLI and Cursor skill are symlinked into:

- `~/.local/bin/nvim-agent`
- `~/.cursor/skills/nvim-agent`

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
