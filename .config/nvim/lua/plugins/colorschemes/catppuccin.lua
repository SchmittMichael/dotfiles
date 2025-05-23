return {
  "catppuccin/nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
