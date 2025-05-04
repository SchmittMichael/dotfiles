return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspRestart", "LspInstall", "LspUninstall" },
  config = function()
    vim.lsp.inlay_hint.enable(true)
  end,
  keys = {
    { "<C-s>", vim.lsp.buf.signature_help, mode = { "n", "i" }, desc = "Show function signature" },
    { "K", vim.lsp.buf.hover, mode = { "n" }, desc = "Show function description" },
    { "<leader>rn", vim.lsp.buf.rename, mode = { "n", "v" }, desc = "Lsp rename" },
  },
}
