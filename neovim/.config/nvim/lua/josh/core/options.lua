-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000 -- 10x more undo levels
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indent
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- vim.opt.colorcolumn = "100"

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
vim.opt.scrolloff = 10

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.ttimeout = false
vim.opt.timeout = false

-- Folds
vim.opt.foldmethod = "expr" -- use tree-sitter for folding method
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Disable folds in diffs
vim.opt.diffopt:append("context:99999")
vim.opt.fillchars:append({ diff = "╱" })

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menu,menuone,noselect,popup,fuzzy"
vim.opt.wildmode = "longest,full,full"
vim.opt.wildoptions = "pum,fuzzy"
vim.opt.smoothscroll = true

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.spell = false
vim.opt.spelllang = { "en_au", "en_us" }
vim.opt.spelloptions = "camel,noplainbuffer"

-- Only suggest a maximum of 15 options
vim.opt.pumheight = 15

-- Ensure split opens to the right or below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Disable the statusline and sets the status line as a line: https://github.com/neovim/neovim/issues/18965
vim.opt.statusline = "%#MyLine#%{repeat('─',winwidth('.'))}%*"
vim.opt.laststatus = 0
vim.opt.showmode = true
vim.opt.cmdheight = 0

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.netrw_banner = 0

vim.opt.inccommand = "nosplit"
vim.opt.winheight = 5
