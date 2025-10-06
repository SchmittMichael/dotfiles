-- global options --
vim.g.mapleader = " "

-- default indentation settings
vim.cmd("filetype indent on")
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- linenumbers
vim.wo.relativenumber = true
vim.wo.number = true

-- split directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- set case insensitivity as default
vim.opt.ic = true

-- other
vim.opt.langmenu = "en_US"
vim.opt.undofile = true
vim.opt.scrolloff = 8


-- keymap options --
-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- clear search highlighting
vim.keymap.set("n", "<leader>cs", ":nohlsearch<CR>")

-- ctrl+backspace word delete in insert mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })

-- clipboard
vim.opt.clipboard = "unnamed"
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy selection to system clipboard" })


-- Custom commands --
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

-- Custom behavior --
-- disable syntax tree features on large files
TS_MAX_LINES = 3000

-- enable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})
