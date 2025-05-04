return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      return vim.api.nvim_buf_line_count(bufnr) < TS_MAX_LINES
    end,
    max_lines = 3,
  }
}
