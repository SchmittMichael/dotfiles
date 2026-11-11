return {
  "oxfist/night-owl.nvim",
  enabled = false,
  priority = 1000,
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    vim.cmd.colorscheme("night-owl")
  end,
}
