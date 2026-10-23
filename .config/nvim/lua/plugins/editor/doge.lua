return {
  "kkoomen/vim-doge",
  cmd = "DogeGenerate",
  keys = {
    { "<leader>d", desc = "Docstring generation" },
  },
  config = function(plugin)
    if not (vim.uv or vim.loop).fs_stat(vim.g.doge_install_path .. "/bin/vim-doge-helper") then
      vim.cmd("call doge#install()")
    end

    -- Files already open when the first command/key loads Doge have not run its
    -- ftplugins yet. Initialize only Doge's files, including filetype aliases.
    local aliases = vim.g.doge_filetype_aliases
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        local ft = vim.bo[bufnr].filetype
        for language, filetypes in pairs(aliases) do
          if vim.tbl_contains(filetypes, ft) then
            ft = language
            break
          end
        end
        local ftplugin = plugin.dir .. "/ftplugin/" .. ft .. ".vim"
        if (vim.uv or vim.loop).fs_stat(ftplugin) then
          vim.api.nvim_buf_call(bufnr, function() vim.cmd.source(vim.fn.fnameescape(ftplugin)) end)
        end
      end
    end
  end,
}
