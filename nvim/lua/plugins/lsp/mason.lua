return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()

      -- import mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          "ansiblels",
          "bashls",
          "dockerls",
          "docker_compose_language_service",
          "html",
          "lua_ls",
          -- "gopls",
          "emmet_ls",
          "texlab",
          "pyright",
          "ruff",
          "ts_ls",
          "yamlls",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })

      local lspconfig = require("lspconfig")
      mason_lspconfig.setup_handlers({
        function(server) lspconfig[server].setup({}) end,
      })

      mason_tool_installer.setup({
        ensure_installed = {
          -- formatter
          "prettier", -- prettier
          "stylua", -- lua
          "isort", -- python imports
          "black", -- python
          "shfmt", -- bash
          -- linter
          "pylint", -- python
          "shellcheck", -- bash
        },
      })
    end,
  },
}
