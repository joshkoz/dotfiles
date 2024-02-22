-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Show whitespace
-- vim.opt.list = true
-- vim.opt.listchars = "tab:>\\ ,trail:-,eol:⏎"

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Enable Relative Line Numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.ttimeout = false
vim.opt.timeout = false

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"
vim.opt.wildmode = "longest,full,full"
vim.opt.wildoptions = "fuzzy" -- Make the command prompt fuzzy search
vim.opt.smoothscroll = true

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.spelllang = { "en_au", "en_us" }

-- Only suggest a maximum of 15 options
vim.opt.pumheight = 15

-- Ensure split opens to the right or below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Disable the statusline and sets the status line as a line: https://github.com/neovim/neovim/issues/18965
-- vim.opt.statusline = "%#WinSeparator#%{repeat('─',winwidth('.'))}%*"
vim.opt.laststatus = 3
vim.opt.showmode = false
