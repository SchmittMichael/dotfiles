return {
  "lervag/vimtex",
  ft = "tex",
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.Tex_GotoError = 0
    vim.g.vimtex_view_sync_method = "auto"
    vim.g.vimtex_view_autoreload = 1
    vim.g.vimtex_quickfix_mode = 0 -- disables compiler warning window
    vim.g.vimtex_highlight_enabled = 0
  end,
}
