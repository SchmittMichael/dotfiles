-- Python specific settings
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.formatoptions:append("croql")

-- Set fold method
-- vim.opt_local.foldmethod = 'indent'

-- Enable Python highlighting
vim.g.python_highlight_all = 1

-- Experimental stuff, don't know what it does or if it's usefull, doesn't work
-- -- Highlight group for bad whitespace
-- vim.api.nvim_set_hl(0, 'BadWhitespace', { ctermbg = 'red', guibg = 'red' })
--
-- -- Match bad whitespace (tabs at beginning of line) in Python files
-- vim.cmd([[
--     augroup PythonBadWhitespace
--         autocmd!
--         autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
--     augroup END
-- ]])
