return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      min_count_to_highlight = 2,
      large_file_cutoff = TS_MAX_LINES,
      case_insensitive_regex = true,
    })
  end,
}
