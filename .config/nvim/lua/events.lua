vim.api.nvim_create_augroup("CustomEvents", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = "CustomEvents",
  pattern = "*.*", -- only trigger in files, not other windows
  callback = function()
    if vim.b.first_insert_enter_handled == nil or vim.b.first_insert_enter_handled == false then
      vim.b.first_insert_enter_handled = true
    else
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local attached_lsps = vim.lsp.get_active_clients({ bufnr = bufnr })

    if #attached_lsps > 0 then
      -- trigger custom event for nvim-cmp to pick up on
      vim.api.nvim_exec_autocmds("User", { pattern = "InsertEnterWithLsp" })
      -- trigger InsertEnter again for internal nvim-cmp logic to attach
      vim.api.nvim_exec_autocmds("InsertEnter", { pattern = "*" })
    end
  end,
})
