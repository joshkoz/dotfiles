-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.backup = false
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Enable Relative Line Numbers
vim.o.relativenumber = true
vim.o.scrolloff = 8

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300
vim.o.ttimeout = false
vim.o.timeout = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.o.scrolloff = 8

vim.g.autoformat_enabled = true
vim.g.cmd_enabled = true
vim.o.wrap = false

-- only suggest a maximum of 15 options
vim.o.pumheight = 15

-- ensure split opens to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "nosplit"

vim.o.foldenable = false

-- Disable the statusline
vim.o.laststatus = 0
-- Sets the status line as a line: https://github.com/neovim/neovim/issues/18965
vim.o.statusline = "%#MyStatusLine#%{repeat('─',winwidth('.'))}%*"

vim.o.wildmode = "longest,list,full"
-- Make the command prompt fuzzy search
vim.o.wop = "fuzzy"

vim.opt.spelllang = { "en_au", "en_us" }

vim.g.colorscheme = "kanagawa"
