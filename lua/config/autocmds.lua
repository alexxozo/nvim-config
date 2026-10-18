-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Spell on text buffers, but not markdown (LazyVim enables spell for markdown by default).
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local function focus_markdown_read(buf)
  if vim.bo[buf].filetype ~= "markdown" and vim.bo[buf].filetype ~= "markdown.mdx" then
    return
  end
  vim.opt_local.wrap = true
  vim.opt_local.spell = false
  vim.diagnostic.enable(false, { bufnr = buf })
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("focus_markdown_read", { clear = true }),
  callback = function(args)
    focus_markdown_read(args.buf)
  end,
})
