return {
  "mbbill/undotree",
  config = function ()
    vim.g.undotree_WindowLayout = 3 -- open split to right side
  end,
  keys = {
    { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
  },
}
