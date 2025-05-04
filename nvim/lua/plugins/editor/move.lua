return {
  "fedepujol/move.nvim",
  opts = {
    char = { enable = true },
  },
  cmd = { "MoveLine", "MoveHChar", "MoveBlock", "MoveHBlock", "MoveWord" },
  keys = {
    { "<A-j>", ":MoveLine 1<CR>", mode = { "n" } },
    { "<A-k>", ":MoveLine -1<CR>", mode = { "n" } },
    { "<A-h>", ":MoveHChar -1<CR>", mode = { "n" } },
    { "<A-l>", ":MoveHChar 1<CR>", mode = { "n" } },
    { "<leader>wf", ":MoveWord 1<CR>", mode = { "n" } },
    { "<leader>wb", ":MoveWord -1<CR>", mode = { "n" } },
    { "<A-j>", ":MoveBlock 1<CR>", mode = { "v" } },
    { "<A-k>", ":MoveBlock -1<CR>", mode = { "v" } },
    { "<A-h>", ":MoveHBlock -1<CR>", mode = { "v" } },
    { "<A-l>", ":MoveHBlock 1<CR>,", mode = { "v" } },
  },
}
