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
    { "<C-s>", function() vim.lsp.buf.signature_help() end, mode = { "n", "i" }, desc = "Show function signature" },
    { "K", function() vim.lsp.buf.hover() end, mode = { "n" }, desc = "Show function description" },
    { "<leader>rn", function() vim.lsp.buf.rename() end, mode = { "n", "v" }, desc = "Lsp rename" },
  },
}
