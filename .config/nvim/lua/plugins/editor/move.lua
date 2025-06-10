return {
  "fedepujol/move.nvim",
  opts = {
    char = { enable = true },
  },
  cmd = { "MoveLine", "MoveHChar", "MoveBlock", "MoveHBlock", "MoveWord" },
  keys = {
    { "<A-j>", ":MoveLine 1<CR>", mode = { "n" }, silent = true },
    { "<A-k>", ":MoveLine -1<CR>", mode = { "n" }, silent = true },
    { "<A-h>", ":MoveHChar -1<CR>", mode = { "n" }, silent = true },
    { "<A-l>", ":MoveHChar 1<CR>", mode = { "n" }, silent = true },
    { "<leader>wf", ":MoveWord 1<CR>", mode = { "n" }, silent = true },
    { "<leader>wb", ":MoveWord -1<CR>", mode = { "n" }, silent = true },
    { "<A-j>", ":MoveBlock 1<CR>", mode = { "v" }, silent = true },
    { "<A-k>", ":MoveBlock -1<CR>", mode = { "v" }, silent = true },
    { "<A-h>", ":MoveHBlock -1<CR>", mode = { "v" }, silent = true },
    { "<A-l>", ":MoveHBlock 1<CR>,", mode = { "v" }, silent = true },
  },
}
