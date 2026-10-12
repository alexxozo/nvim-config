-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Mouse side buttons ≈ IntelliJ back / forward (jump list)
-- Also: Ctrl-o (back), Ctrl-i (forward)
vim.keymap.set({ "n", "v" }, "<X1Mouse>", "<C-o>", { desc = "Jump back" })
vim.keymap.set({ "n", "v" }, "<X2Mouse>", "<C-i>", { desc = "Jump forward" })
