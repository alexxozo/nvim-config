---
name: nvim-agent
description: >-
  Control the user's live Neovim session via the nvim-agent CLI (open files,
  jump to lines, run commands, inspect buffer state). Use when the user asks
  you to show something in Neovim, change what they're looking at, run a Vim
  command in their editor, or drive their focused nvim UI.
---

# nvim-agent

Drive the user's **already running** Neovim through the `nvim-agent` CLI. Works with any agent that can run shell commands (Cursor, Codex, Claude Code, etc.).

## Prerequisites

- Neovim is open (config publishes `~/.cache/nvim-agent/server`)
- CLI on PATH: `nvim-agent` (usually `~/.local/bin/nvim-agent`)

If status fails, ask the user to focus Neovim once (or run `:NvimAgentStatus`), then retry.

## When to use

- "Show me X in nvim", "open this file at line N", "run this in my editor"
- Inspect what file/line they are on before advising
- Prefer this when they want the **UI** to move

Do **not** use this for normal repo edits you can do with file tools; use it for **live UI control**.

## Commands

```bash
nvim-agent status          # server + cwd + file
nvim-agent info            # JSON: cwd, file, line, col, modified, filetype
nvim-agent open PATH [LINE]
nvim-agent cmd 'ExCommandWithoutColon'
nvim-agent lua 'vim.fn.getcwd()'
nvim-agent send 'keys'     # e.g. "gr" or ":LazyGit<CR>"
nvim-agent eval-file
```

### Examples

```bash
nvim-agent open src/phi/__init__.py 42
nvim-agent cmd 'Gitsigns diffthis'
nvim-agent send ':lua vim.lsp.buf.references()<CR>'
nvim-agent info
```

## Rules

1. Call `nvim-agent status` or `info` first if unsure Neovim is reachable.
2. Use absolute paths with `open` when possible.
3. Prefer `open file line` over sending raw motion keys.
4. Avoid destructive commands (`qa!`, `bwipeout!`, mass `:bufdo`) unless the user asked.
5. After UI actions, briefly tell the user what you did in their editor.
