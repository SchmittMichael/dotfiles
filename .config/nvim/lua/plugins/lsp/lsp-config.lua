return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.lsp.inlay_hint.enable(true)

    vim.lsp.config["tinymist"] = {
      cmd = { "tinymist" },
      filetypes = { "typst" },
      settings = {
        formatterMode = "typstyle",
      },
    }

    vim.api.nvim_create_user_command(
      "LspInfo",
      function() vim.cmd(":checkhealth vim.lsp") end,
      { desc = "Informations about active lsp clients." }
    )
  end,
  keys = {
    { "<C-s>", vim.lsp.buf.signature_help, mode = { "n", "i" }, desc = "Show function signature" },
    { "K", vim.lsp.buf.hover, mode = { "n" }, desc = "Show function description" },
    { "<leader>rn", vim.lsp.buf.rename, mode = { "n", "v" }, desc = "Lsp rename" },
  },
}
