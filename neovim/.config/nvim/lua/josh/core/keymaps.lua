-- Set space as the leader key
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Unmap space from moving right" })
vim.keymap.set({ "n", "v" }, "<Space>e", vim.cmd.Ex, { silent = true, desc = "Open the file explorer" })

vim.keymap.set("n", "<leader><leader>", "<CMD>b#<CR>", { desc = "Go to the alternate buffer" })
vim.keymap.set("n", "<leader>/", "<CMD>noh<CR>", { desc = "Turn off hlsearch" })

vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]], { desc = "Cut to blank hole register" })
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank into clipboard register" })

-- Move visual selection
vim.keymap.set("v", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up a line" })
vim.keymap.set("v", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down a line" })

-- Diffs
vim.keymap.set("n", "<leader>dg<Left>", "<CMD>diffget //2<CR><CMD>diffupdate<CR>", { desc = "Diffget from the left" })
vim.keymap.set("n", "<leader>dg<Right>", "<CMD>diffget //3<CR><CMD>diffupdate<CR>", { desc = "Diffget from the right" })

--- Quickfix
vim.keymap.set("n", "<A-j>", "<CMD>cnext<CR>", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<A-k>", "<CMD>cprev<CR>", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set("n", "<leader>x", "<CMD>copen<CR>", { desc = "Open the Quickfix list" })

-- Tmux
vim.keymap.set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")
