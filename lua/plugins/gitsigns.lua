-- Inline blame on the current line (IntelliJ-style annotate lite)
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 400,
      virt_text_pos = "eol",
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
  },
}
