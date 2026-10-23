return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "x" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "x" }, desc = "Comment toggle blockwise" },
      { "gcc", desc = "Comment toggle current line" },
      { "gbc", desc = "Comment toggle current block" },
      { "gco", desc = "Comment insert below" },
      { "gcO", desc = "Comment insert above" },
      { "gcA", desc = "Comment insert end of line" },
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {
      search = {
        pattern = [[\b(KEYWORDS)(\s\([^()]*\))?:]],
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>tT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
