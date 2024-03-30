-- Set space as the leader key
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Unmap space from moving right in normal mode" })
vim.keymap.set({ "n", "v" }, "<Space>e", vim.cmd.Ex, { silent = true, desc = "Open the file explorer" })

vim.keymap.set("n", "<leader><leader>", "<CMD>b#<CR>", { desc = "Go to the alternate buffer" })
vim.keymap.set("n", "<leader>/", "<CMD>noh<CR>", { desc = "Turn off hlsearch" })

vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })
vim.keymap.set("n", "<leader>d", [["_d]], { desc = "Cut to blank hole register" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into clipboard register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into clipboard register" })

-- Move visual selection
vim.keymap.set("v", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up a line" })
vim.keymap.set("v", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down a line" })

-- Diffs
vim.keymap.set("n", "<leader>dh", "<CMD>diffget //2<CR><CMD>diffupdate<CR>", { desc = "Diffget from the left" })
vim.keymap.set("n", "<leader>dl", "<CMD>diffget //3<CR><CMD>diffupdate<CR>", { desc = "Diffget from the right" })

--- Quickfix
vim.keymap.set("n", "<A-j>", "<CMD>cnext<CR>zz", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<A-k>", "<CMD>cprev<CR>zz", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set("n", "<leader>co", "<CMD>copen<CR>", { desc = "Open the Quickfix list" })

-- Tmux
vim.keymap.set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")
