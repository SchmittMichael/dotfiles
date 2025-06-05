vim.cmd("filetype indent on")

-- default indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- clear search highlighting
vim.keymap.set("n", "<leader>cs", ":nohlsearch<CR>")

-- ctrl+backspace word delete in insert mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })

-- linenumbers
vim.wo.relativenumber = true
vim.wo.number = true

-- scrolloff
vim.opt.scrolloff = 8

-- split
vim.cmd("set splitright")

-- clipboard
vim.opt.clipboard = "unnamed"
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy selection to system clipboard" })

-- set case insensitivity as default
vim.cmd("set ic")

-- add buffer write + buffer delete command
vim.api.nvim_create_user_command("Bx", ":bw", { desc = "Write and quit current buffer." })

-- add force quit alias
vim.api.nvim_create_user_command("Q", ":qa!", { desc = "Force quit Neovim without saving." })

-- Create force completions logic init command
vim.api.nvim_create_user_command("Completions", function()
  vim.cmd(":LspRestart")
  vim.cmd(":Lazy load nvim-cmp")
end, { desc = "Enable completions." })

-- enable spell checking
vim.api.nvim_create_user_command("Spell", ":setlocal spell spelllang=en_us", { desc = "Enable spell cheking." })

-- set language to english on windows
-- vim.cmd("language en_US.UTF-8") -- disabled because of issues in wsl
vim.cmd("set langmenu=en_US")

-- disable syntax tree features on large files
TS_MAX_LINES = 3000

-- enable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})
