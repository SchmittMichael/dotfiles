local queries = {}

local function telescope_persistence(name, opts, persistence_key)
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  opts = vim.deepcopy(opts or {})

  persistence_key = persistence_key or name

  local previous = queries[persistence_key] or ""
  opts.default_text = previous

  local original_attach = opts.attach_mappings

  opts.attach_mappings = function(prompt_bufnr, map)
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = prompt_bufnr,
      once = true,
      callback = function() queries[persistence_key] = action_state.get_current_line() end,
    })

    -- escape in visual mode instantly
    vim.keymap.set("v", "<esc>", function() actions.close(prompt_bufnr) end, {
      buffer = prompt_bufnr,
      nowait = true,
    })

    -- If there was a previous query, select it.
    if previous ~= "" then
      vim.schedule(function()
        if vim.api.nvim_get_current_buf() == prompt_bufnr then
          local picker = action_state.get_current_picker(prompt_bufnr)
          local prompt_prefix = picker.prompt_prefix or "> "

          vim.cmd("stopinsert")

          -- Move to the first character after the Telescope prompt prefix.
          vim.api.nvim_win_set_cursor(0, { 1, #prompt_prefix })
          vim.cmd("normal! v$")
        end
      end)
    end

    if original_attach then
      return original_attach(prompt_bufnr, map)
    end

    return true
  end

  builtin[name](opts)
end

local function persistent_picker(name, opts, persistence_key)
  return function() telescope_persistence(name, opts, persistence_key) end
end

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
    {
      "<leader>gd",
      persistent_picker("lsp_definitions"),
      mode = "n",
      desc = "Show lsp definitions",
    },
    {
      "<leader>gr",
      persistent_picker("lsp_references"),
      mode = "n",
      desc = "Show lsp references",
    },

    -- Not Telescope
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      mode = "n",
      desc = "Show code actions",
    },

    -- Often used
    {
      "<leader>fg",
      persistent_picker("grep_string", {
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
      }, "grep_words"),
      mode = "n",
      desc = "Grepping in files",
    },

    {
      "<leader>ff",
      persistent_picker("find_files", nil, "find_files"),
      mode = "n",
      desc = "Find in files",
    },

    {
      "<leader>fF",
      persistent_picker("find_files", {
        hidden = true,
      }, "find_all_files"),
      mode = "n",
      desc = "Find in all files",
    },

    {
      "<leader>:",
      persistent_picker("command_history"),
      mode = "n",
      desc = "View command history",
    },

    {
      "<leader>fs",
      persistent_picker("grep_string", nil, "find_string"),
      mode = { "n", "v" },
      desc = "Find string in files",
    },

    -- Telescope prefix
    {
      "<leader>tb",
      persistent_picker("buffers"),
      mode = "n",
      desc = "Show active buffers",
    },

    {
      "<leader>tr",
      function() require("telescope.builtin").resume() end,
      mode = "n",
      desc = "Resume telescope",
    },

    {
      "<leader>tk",
      persistent_picker("keymaps"),
      mode = "n",
      desc = "Show all keymaps",
    },

    {
      "<leader>to",
      persistent_picker("oldfiles"),
      mode = "n",
      desc = "Show recent files",
    },

    {
      "<leader>tgc",
      persistent_picker("git_commits"),
      mode = "n",
      desc = "Show git commits",
    },

    {
      "<leader>tgb",
      persistent_picker("git_branches"),
      mode = "n",
      desc = "Show git branches",
    },

    {
      "<leader>tgs",
      persistent_picker("git_status"),
      mode = "n",
      desc = "Show git status",
    },
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
