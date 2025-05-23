local packages = {
  -- lsps --
  -- "ansible-language-server",
  "bash-language-server",
  "dockerfile-language-server",
  "docker-compose-language-service",
  "html-lsp",
  "lua-language-server",
  -- "gopls",
  "emmet-ls",
  "texlab",
  "pyright",
  "ruff",
  "typescript-language-server",
  "yaml-language-server",
  -- formatter --
  "prettier",
  "stylua",
  "isort",
  "black",
  "shfmt",
  -- linter --
  "pylint",
  "shellcheck",
}

local info = vim.log.levels.INFO
local warn = vim.log.levels.WARN
local error = vim.log.levels.ERROR

local function mason_notify(message, level)
  return function() vim.notify("(Mason) " .. message, level, { title = "Mason Install" }) end
end

local function install_packages(mr)
  for _, name in ipairs(packages) do
    local ok, pkg = pcall(mr.get_package, name)
    if not ok then
      vim.schedule(mason_notify("Package not found: " .. name, error))
    else
      if pkg:is_installed() then
        vim.schedule(mason_notify("Already installed: " .. name, info))
      elseif pkg:is_installing() then
        vim.schedule(mason_notify("Already installing: " .. name, warn))
      else
        pkg:once("install:success", function() vim.schedule(mason_notify("Installed: " .. name, info)) end)
        pkg:once("install:failed", function() vim.schedule(mason_notify("Failed to install: " .. name, error)) end)
        pkg:install()
      end
    end
  end
end

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    lazy = true,
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {},
    init = function()
      local mr = require("mason-registry")

      if next(mr.get_installed_package_names()) == nil then
        install_packages(mr)
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
