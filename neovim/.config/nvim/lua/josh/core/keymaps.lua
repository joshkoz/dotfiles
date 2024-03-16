-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Unmap space from moving right in normal mode" })
vim.keymap.set({ "n", "v" }, "<Space>e", vim.cmd.Ex, { silent = true, desc = "Open the file explorer" })

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Go to the alternate buffer" })

vim.keymap.set("x", "<leader>p", [["_P]], { desc = "Paste without yank" })
vim.keymap.set("n", "<leader>d", [["_d]], { desc = "Delete without yank" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into clipboard" })

-- Moving a visual selection up or down a line with J and K
vim.keymap.set("v", "K", ":m '<-2<CR>gvgv=gv", { desc = "Move visual selection up a line" }) -- weird timing bug with only gv=gv for more than 3 lines selected
vim.keymap.set("v", "J", ":m '>+1<CR>gvgv=gv", { desc = "Move visual selection down a line" })

-- Buffers
vim.keymap.set("n", "]b", "<cmd>bnext<CR>zz", { desc = "Go to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<CR>zz", { desc = "Go to previous buffer" })

-- Diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Diffs
vim.keymap.set("n", "<leader>dl", "<cmd>diffget //2<CR>", { desc = "Diffget from the left" })
vim.keymap.set("n", "<leader>dr", "<cmd>diffget //3<CR>", { desc = "Diffget from the right" })

--- Quickfix
vim.keymap.set("n", "<A-j>", "<cmd>cnext<CR>zz", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<A-k>", "<cmd>cprev<CR>zz", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open the Quickfix list" })

-- Tmux
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
