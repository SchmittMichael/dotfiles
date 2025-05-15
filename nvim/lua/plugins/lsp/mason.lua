return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        -- "ansibles",
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
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    opts = {
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
    },
  },
}
