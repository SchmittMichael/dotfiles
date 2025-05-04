return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    -- LSP related
    { "<leader>gd", ":Telescope lsp_definitions<CR>", mode = { "n" }, desc = "Show lsp definitions" },
    { "<leader>gr", ":Telescope lsp_references<CR>", mode = { "n" }, desc = "Show lsp references" },
    { "<leader>ca", vim.lsp.buf.code_action, mode = { "n" }, desc = "Show code actions" },
    -- Often used
    {
      "<leader>fg",
      function()
        require("telescope.builtin").grep_string({
          shorten_path = true,
          word_match = "-w",
          only_sort_text = true,
          search = "",
        })
      end,
      desc = "Grepping in files",
    },
    { "<leader>ff", ":Telescope find_files<CR>", mode = { "n" }, desc = "Find in files" },
    {
      "<leader>fF",
      function() require("telescope.builtin").find_files({ hidden = true }) end,
      mode = { "n" },
      desc = "Find in all files",
    },
    { "<leader>fs", ":Telescope grep_string<CR>", mode = { "n", "v" }, desc = "Find string in files" },
    -- Telescope prefix
    { "<leader>tb", ":Telescope buffers<CR>", desc = "Show active buffers" },
    { "<leader>tr", ":Telescope resume<CR>", mode = { "n" }, desc = "Resume telescope" },
    { "<leader>tk", ":Telescope keymaps<CR>", mode = { "n" }, desc = "Show all keymaps" },
    { "<leader>tgc", ":Telescope git_commits<CR>", mode = { "n" }, desc = "Show git commits" },
    { "<leader>tgb", ":Telescope git_branches<CR>", mode = { "n" }, desc = "Show git branches" },
    { "<leader>tgs", ":Telescope git_status<CR>", mode = { "n" }, desc = "Show git status" },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = false,
            ["<esc>"] = actions.close,
          },
        },
      },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
  end,
}
