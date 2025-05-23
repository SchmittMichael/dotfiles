return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Neotree" },
  keys = {
    { "<C-n>", ":Neotree filesystem toggle left<CR>" },
  },
  opt = {
    buffers = { follow_current_file = { enabled = true } },
  },
}
