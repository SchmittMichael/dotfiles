return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    columns = { "icon", "permissions", "size", "mtime" },
    keymaps = {
      ["<C-h>"] = false,
      ["<M-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    { "-", ":Oil<CR>", mode = { "n" }, desc = "Open parent directory" },
    { "<leader>-", function() require("oil").toggle_float() end, mode = { "n" }, desc = "Open parent directory" },
  },
  cmd = { "Oil" },
}
