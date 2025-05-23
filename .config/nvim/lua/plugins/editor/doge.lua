require("utils")
return {
  "kkoomen/vim-doge",
  -- TODO: make more lazy
  event = { "BufReadPre", "BufNewFile" },
  -- currently unnecessary
  keys = {
    { "<leader>d", desc = "Docstring generation" },
  },
  config = function()
    if not File_exists(vim.g.doge_install_path .. "/bin/vim-doge-helper") then
      vim.cmd("call doge#install()")
    end
  end,
}
