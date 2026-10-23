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

-- command mode option
vim.keymap.set("c", "<C-k>", "<C-p>")
vim.keymap.set("c", "<C-j>", "<C-n>")

-- keymap options --
-- clear search highlighting
vim.keymap.set("n", "<leader>cs", ":nohlsearch<CR>")

-- ctrl+backspace word delete in insert mode
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })

-- clipboard
-- Neovim probes xsel through &shell, which is expensive with a configured Fish
-- shell. Use the same provider after checking it directly, retaining automatic
-- detection for Wayland tools, custom providers, and unsuccessful X11 probes.
local wayland_clipboard = (vim.env.WAYLAND_DISPLAY or "") ~= ""
  and (
    (vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1)
    or (vim.fn.executable("waycopy") == 1 and vim.fn.executable("waypaste") == 1)
  )
if
  vim.g.clipboard == nil
  and vim.fn.has("mac") == 0
  and (vim.env.DISPLAY or "") ~= ""
  and not wayland_clipboard
  and vim.fn.executable("xsel") == 1
then
  vim.fn.system({ "xsel", "-o", "-b" })
  if vim.v.shell_error == 0 then
    vim.g.clipboard = {
      name = "xsel",
      copy = {
        ["+"] = { "xsel", "--nodetach", "-i", "-b" },
        ["*"] = { "xsel", "--nodetach", "-i", "-p" },
      },
      paste = { ["+"] = { "xsel", "-o", "-b" }, ["*"] = { "xsel", "-o", "-p" } },
      cache_enabled = 1,
    }
  end
end
vim.opt.clipboard = "unnamed"
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Copy selection to system clipboard" })

-- Custom commands --
-- add buffer write + buffer delete command
vim.api.nvim_create_user_command("Bx", ":bw", { desc = "Write and quit current buffer." })

-- add force quit alias
vim.api.nvim_create_user_command("Q", ":qa!", { desc = "Force quit Neovim without saving.", range = true })

-- Create force completions logic init command
vim.api.nvim_create_user_command("Completions", function()
  vim.cmd(":lsp restart")
  vim.cmd(":Lazy load nvim-cmp")
end, { desc = "Enable completions." })

-- enable spell checking
vim.api.nvim_create_user_command("Spell", ":setlocal spell spelllang=en_us", { desc = "Enable spell cheking." })

-- buffer-local Tree-sitter highlighting controls
local function disable_ts_highlight()
  vim.b.ts_highlight_disabled = true
  vim.treesitter.stop(0)
end

local function enable_ts_highlight()
  local ok, err = pcall(vim.treesitter.start, 0)
  if not ok then
    vim.notify("Cannot enable Tree-sitter highlighting: " .. tostring(err), vim.log.levels.WARN)
    return
  end
  vim.b.ts_highlight_disabled = false
end

vim.api.nvim_create_user_command(
  "TSHighlightDisable",
  disable_ts_highlight,
  { desc = "Disable Tree-sitter highlighting in the current buffer." }
)
vim.api.nvim_create_user_command(
  "TSHighlightEnable",
  enable_ts_highlight,
  { desc = "Enable Tree-sitter highlighting in the current buffer." }
)
vim.api.nvim_create_user_command("TSHighlightToggle", function()
  if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
    disable_ts_highlight()
  else
    enable_ts_highlight()
  end
end, { desc = "Toggle Tree-sitter highlighting in the current buffer." })

-- Custom behavior --
-- disable syntax tree features on large files
TS_MAX_LINES = 3000

-- enable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})
