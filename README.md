# Neovim config (LazyVim + nvim-agent + Handy/Herdr)

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup with:

- **nvim-agent** — coding agents control the focused Neovim session  
- **Handy → Herdr** — FN dictation can route to a chosen agent pane (or paste natively)

## What's included

| Path | Purpose |
|------|---------|
| `lua/config/` | LazyVim options, keymaps, autocmds |
| `lua/config/nvim-agent.lua` | Publishes RPC address for remote control |
| `bin/nvim-agent` | Drive Neovim from the shell / agents |
| `bin/handy-to-herdr` | Handy external-paste script |
| `bin/handy-target` | Pick Herdr pane vs native Handy paste |
| `skills/nvim-agent/` | Skill doc (Cursor / Codex / …) |
| `install.sh` | Symlinks CLIs + skills; configures Handy if present |
| `lazyvim.json` | Enabled LazyVim extras |

## Fresh machine

```bash
# requires: git, Neovim 0.11+, curl
# optional: Handy, Herdr, fzf (for handy-target)
git clone git@github.com:alexxozo/nvim-config.git ~/.config/nvim
~/.config/nvim/install.sh
nvim   # first launch installs plugins
nvim-agent status
handy-target   # choose routing mode
```

`install.sh` links into:

- `~/.local/bin/{nvim-agent,handy-to-herdr,handy-target}`
- `~/.cursor/skills`, `~/.codex/skills`, `~/.agents/skills` (if those apps exist)
- Handy `settings_store.json` → external paste script (macOS, if Handy is installed)

## Handy / Herdr

```bash
handy-target
```

- **herdr-auto / herdr-pin** — FN → Herdr agent pane  
- **native** — FN pastes into whatever is focused  

Pin file: `~/.config/herdr/handy-target`  
Mode file: `~/.config/herdr/handy-mode`  
Log: `~/.cache/handy-to-herdr.log`

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
