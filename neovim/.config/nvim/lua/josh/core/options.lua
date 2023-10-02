-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Enable Relative Line Numbers
vim.o.relativenumber = true
vim.o.scrolloff = 8

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.incsearch = true

vim.g.autoformat_enabled = true
vim.g.cmd_enabled = true
vim.o.wrap = false

-- only suggest a maximum of 15 options
vim.o.pumheight = 15

-- ensure split opens to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

-- ensure netrw doesn't load with neotree
-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/983
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
