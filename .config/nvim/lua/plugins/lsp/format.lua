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
        -- programming language specific
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        -- graphics programming
        glsl = { "clang_format" },
        vert = { "clang_format" },
        frag = { "clang_format" },
        geom = { "clang_format" },
        comp = { "clang_format" },
        -- shell
        fish = { "fish_indent" },
        sh = { "shfmt" },
        -- webdev
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        -- config formats
        json = { "prettier" },
        jsonc = { "prettier" },
        toml = { "taplo" },
        xml = { "xmllint" },
        yaml = { "prettier" },
        -- other
        markdown = { "prettier" },
        sql = { "sql_formatter" },
        tex = { "latexindent" },
      },
      -- format_on_save = format_opts,
    })

    conform.formatters.shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    }
    conform.formatters.isort = {
      prepend_args = { "-l", "120", "--profile", "black" },
    }
    conform.formatters.black = {
      prepend_args = { "-l", "120" },
    }
    conform.formatters.xmllint = {
      prepend_args = { "--format" },
    }
  end,
}
