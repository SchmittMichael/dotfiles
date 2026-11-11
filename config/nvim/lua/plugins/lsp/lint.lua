return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      python = { "pylint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      sh = { "shellcheck" },
      ansible = { "ansible_lint" },
    }

    -- pylint
    local pylint = lint.linters.pylint
    pylint.args = { "--rcfile", ".pylintrc", "-f", "json" }

    -- ansilbe
    local ansilbe = lint.linters.ansible_lint
    ansilbe.args = { "-c", ".ansible-lint", "-p", "--nocolor" }
  end,
  keys = {
    { "<leader>gl", function() require("lint").try_lint() end, desc = "Run linting" },
  },
}
