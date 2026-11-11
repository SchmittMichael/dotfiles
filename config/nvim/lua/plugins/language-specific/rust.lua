return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = "rust",
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
