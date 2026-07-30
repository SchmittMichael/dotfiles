local format_opts = {
  lsp_fallback = true,
  async = false,
  timeout_ms = 1000,
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>gf",
      function() require("conform").format(format_opts) end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        fish = { "fish_indent" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        tex = { "latexindent" },
        toml = { "taplo" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        xml = { "xmllint" },
        yaml = { "prettier" },
      },
      -- format_on_save = format_opts,
    })

    -- shfmt settings
    conform.formatters.shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    }

    -- isort settings
    conform.formatters.isort = {
      prepend_args = { "-l", "120", "--profile", "black" },
    }

    -- black settings
    conform.formatters.black = {
      prepend_args = { "-l", "120" },
    }

    conform.formatters.xmllint = {
      prepend_args = { "--format" },
    }
  end,
}
