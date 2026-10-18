return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },
  {
    event = "LazyVimStarted",
    callback = function()
      vim.schedule(function()
        local ok, lint = pcall(require, "lint")
        if ok then
          lint.linters_by_ft.markdown = {}
          lint.linters_by_ft["markdown.mdx"] = {}
        end
      end)
    end,
  },
}
