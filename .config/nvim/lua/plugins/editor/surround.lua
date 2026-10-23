return {
  "nvim-mini/mini.surround",
  version = "*",
  keys = {
    { "sa", mode = { "n", "x" }, desc = "Add surrounding" },
    { "sd", desc = "Delete surrounding" },
    { "sr", desc = "Replace surrounding" },
    { "sf", mode = { "n", "x", "o" }, desc = "Find right surrounding" },
    { "sF", mode = { "n", "x", "o" }, desc = "Find left surrounding" },
    { "sh", desc = "Highlight surrounding" },
  },
  opts = {},
}
