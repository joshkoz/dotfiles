-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 10000 -- 10x more undo levels
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indent
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"
-- vim.o.colorcolumn = "100"

-- Show whitespace
-- vim.o.list = true
-- vim.o.listchars = "tab:>\\ ,trail:-,eol:⏎"

-- Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Enable Relative Line Numbers
vim.o.relativenumber = true
vim.o.scrolloff = 10

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300
vim.o.ttimeout = false
vim.o.timeout = false

-- Folds
vim.o.foldmethod = "expr" -- use tree-sitter for folding method
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99

-- Disable folds in diffs
vim.o.diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram,context:99999"

vim.o.fillchars = "diff:╱"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy"
vim.o.wildmode = "longest,full,full"
vim.o.wildoptions = "fuzzy"
vim.o.smoothscroll = true

vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.spell = false
vim.o.spelllang = "en_au,en_us"
vim.o.spelloptions = "camel,noplainbuffer"

-- Only suggest a maximum of 15 options
vim.opt.pumheight = 15

-- Ensure split opens to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

-- Disable the statusline and sets the status line as a line: https://github.com/neovim/neovim/issues/18965
vim.o.statusline = "%#MyLine#%{repeat('─',winwidth('.'))}%*"
vim.o.laststatus = 0
vim.o.showmode = true
vim.o.cmdheight = 0

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.netrw_banner = 0

vim.o.inccommand = "nosplit"
vim.o.winheight = 5

-- Per project shada file
-- vim.opt.shadafile = (function()
--   local data = vim.fn.stdpath("data")
--
--   local cwd = vim.fn.getcwd()
--   cwd = vim.fs.root(cwd, ".git") or cwd
--
--   local cwd_b64 = vim.base64.encode(cwd)
--
--   local file = vim.fs.joinpath(data, "project_shada", cwd_b64)
--   vim.fn.mkdir(vim.fs.dirname(file), "p")
--
--   return file
-- end)()
