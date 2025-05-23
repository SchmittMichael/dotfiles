return {
  "cameron-wags/rainbow_csv.nvim",
  config = function()
    -- Workaround to fix lazy loading issues for plugin
    require("rainbow_csv").setup()
    require("rainbow_csv.fns").handle_buffer_enter()
  end,
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
}
