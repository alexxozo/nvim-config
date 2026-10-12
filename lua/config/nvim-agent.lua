-- Publish this Neovim instance's RPC address so external tools (nvim-agent CLI)
-- can control the focused session.

local M = {}

local pointer = vim.fn.expand("~/.cache/nvim-agent/server")

local function ensure_server()
  if vim.v.servername ~= nil and vim.v.servername ~= "" then
    return vim.v.servername
  end
  return vim.fn.serverstart()
end

function M.publish()
  local addr = ensure_server()
  if not addr or addr == "" then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(pointer, ":h"), "p")
  vim.fn.writefile({ addr }, pointer)
end

M.publish()

vim.api.nvim_create_autocmd({ "FocusGained", "DirChanged" }, {
  group = vim.api.nvim_create_augroup("nvim_agent_publish", { clear = true }),
  callback = function()
    M.publish()
  end,
})

vim.api.nvim_create_user_command("NvimAgentStatus", function()
  M.publish()
  vim.notify("nvim-agent server: " .. (vim.v.servername or "(none)"), vim.log.levels.INFO)
end, { desc = "Show / refresh nvim-agent RPC address" })

return M
