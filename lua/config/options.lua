-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Absolute line numbers (LazyVim default is relative)
vim.opt.number = true
vim.opt.relativenumber = false

require("config.nvim-agent")
