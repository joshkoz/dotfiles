-- Set space as the leader key
vim.g.mapleader = vim.keycode("<space>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Unmap space from moving right" })
vim.keymap.set({ "n", "v" }, "-", vim.cmd.Ex, { silent = true, desc = "Open the file explorer" })

vim.keymap.set("n", "<leader><leader>", "<CMD>b#<CR>", { desc = "Go to the alternate buffer" })
vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Turn off hlsearch", silent = true })

vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank into clipboard register" })

-- Move visual selection
vim.keymap.set("v", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up a line", silent = true })
vim.keymap.set("v", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down a line", silent = true })

-- Diffs
vim.keymap.set("n", "<leader>d<Left>", "<CMD>diffget //2<CR><CMD>diffupdate<CR>", { desc = "Diffget from the left" })
vim.keymap.set("n", "<leader>d<Right>", "<CMD>diffget //3<CR><CMD>diffupdate<CR>", { desc = "Diffget from the right" })

-- Tabs
vim.keymap.set("n", "<leader>z", "<CMD>tabclose<CR>", { desc = "Close tab" })

--- Quickfix
vim.keymap.set("n", "<A-j>", "<CMD>cnext<CR>", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<A-k>", "<CMD>cprev<CR>", { desc = "Go to previous item in Quickfix List" })

-- Marks
-- vim.keymap.set("n", "`", "<CMD>marks<CR>:normal! `", { remap = false, desc = "Preview marks before jump" })

-- Tmux
vim.keymap.set("n", "<C-f>", "<CMD>!tmux neww tmux-sessionizer<CR>", { silent = true })

-- Splits
-- vim.keymap.set({ "n", "i" }, "<C-h>", "<CMD>wincmd h<CR>")
-- vim.keymap.set({ "n", "i" }, "<C-j>", "<CMD>wincmd j<CR>")
-- vim.keymap.set({ "n", "i" }, "<C-k>", "<CMD>wincmd k<CR>")
-- vim.keymap.set({ "n", "i" }, "<C-l>", "<CMD>wincmd l<CR>")
vim.keymap.set({ "n", "i" }, "<C-Left>", "<cmd>call win_move_separator(winnr('h'), -2)<CR>")
vim.keymap.set({ "n", "i" }, "<C-Right>", "<cmd>call win_move_separator(winnr('h'), 2)<CR>")
vim.keymap.set({ "n", "i" }, "<C-Up>", "<cmd>call win_move_statusline(winnr('k'), -2)<CR>")
vim.keymap.set({ "n", "i" }, "<C-Down>", "<cmd>call win_move_statusline(winnr('k'), 2)<CR>")
