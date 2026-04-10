return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "williamboman/mason.nvim" },
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    opts = {
      highlight = {
        enable = true,
        disable = { "csv" },
      },
      folds = { enable = false },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "python",
        "properties",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(plugin, opts)
      local TS = require(plugin.name)
      TS.setup(opts)

      local installed_parsers = TS.get_available()

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
        callback = function(ev)
          local ft = ev.match

          if
            not vim.tbl_contains(installed_parsers, ft) -- disable TS for non installed parsers
            or vim.api.nvim_buf_line_count(ev.buf) > TS_MAX_LINES -- disable TS for large files
          then
            return
          end

          local enabled = function(feature)
            if opts[feature] == nil or not opts[feature].enable then
              return false
            end

            return not (opts[feature].disable ~= nil and vim.tbl_contains(opts[feature].disable, ft))
          end

          -- enable different features
          if enabled("highlight") then
            pcall(vim.treesitter.start, ev.buf)
          end

          if enabled("indent") then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          if enabled("folds") then
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist

        keymaps = {
          ["]f"] = { "@function.outer", mode = "next_start", desc = "Move to the beginning of the next function" },
          ["]c"] = { "@class.outer", mode = "next_start", desc = "Move to the beginning of the next class" },

          ["]F"] = { "@function.outer", mode = "next_end", desc = "Move to the end of the next function" },
          ["]C"] = { "@class.outer", mode = "next_end", desc = "Move to the end of the next class" },

          ["[f"] = { "@function.outer", mode = "prev_start", desc = "Move to the beginning of the previous function" },
          ["[c"] = { "@class.outer", mode = "prev_start", desc = "Move to the beginning of the previous class" },

          ["[F"] = { "@function.outer", mode = "prev_end", desc = "Move to the end of the previous function" },
          ["[C"] = { "@class.outer", mode = "prev_end", desc = "Move to the end of the previous class" },
        },
      },
      select = {
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

        keymaps = {
          ["af"] = { "@function.outer", desc = "Select the whole function" },
          ["if"] = { "@function.inner", desc = "Select the inner part of a function" },
          ["ac"] = { "@class.outer", desc = "Select the whole class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "V", -- linewise
        },
      },
    },
    config = function(plugin, opts)
      require(plugin.name).setup(opts)

      -- setup for select keybinds
      local ts_to_select = require("nvim-treesitter-textobjects.select")
      for keys, textobj in pairs(opts.select.keymaps) do
        local query = textobj.query or textobj[1]
        local query_group = textobj.query_group or "textobjects"

        vim.keymap.set(
          { "x", "o" },
          keys,
          function() ts_to_select.select_textobject(query, query_group) end,
          { desc = textobj.desc }
        )
      end

      -- setup for move keybinds
      local ts_to_move = require("nvim-treesitter-textobjects.move")
      local move_functions = {
        next_start = ts_to_move.goto_next_start,
        next_end = ts_to_move.goto_next_end,
        prev_start = ts_to_move.goto_previous_start,
        prev_end = ts_to_move.goto_previous_end,
      }
      for keys, textobj in pairs(opts.move.keymaps) do
        local query = textobj.query or textobj[1]

        vim.keymap.set(
          { "n", "x", "o" },
          keys,
          function() move_functions[textobj.mode](query, "textobjects") end,
          { desc = textobj.desc }
        )
      end
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "xml",
      "jsx",
      "tsx",
    },
    opts = {},
  },
}
