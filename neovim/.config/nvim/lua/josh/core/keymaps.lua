-- Set space as the leader key
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Unmap space from moving right" })
vim.keymap.set({ "n", "v" }, "-", vim.cmd.Ex, { silent = true, desc = "Open the file explorer" })

vim.keymap.set("n", "<leader><leader>", "<CMD>b#<CR>", { desc = "Go to the alternate buffer" })
vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Turn off hlsearch" })

vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "Paste from yank register" })
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank into clipboard register" })

-- Move visual selection
vim.keymap.set("v", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up a line", silent = true })
vim.keymap.set("v", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down a line", silent = true })

-- Diffs
vim.keymap.set("n", "<leader>dg<Left>", "<CMD>diffget //2<CR><CMD>diffupdate<CR>", { desc = "Diffget from the left" })
vim.keymap.set("n", "<leader>dg<Right>", "<CMD>diffget //3<CR><CMD>diffupdate<CR>", { desc = "Diffget from the right" })

--- Quickfix
vim.keymap.set("n", "<A-j>", "<CMD>cnext<CR>", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<A-k>", "<CMD>cprev<CR>", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set("n", "<A-l>", "<CMD>cnewer<CR>", { desc = "Go to next Quickfix List" })
vim.keymap.set("n", "<A-h>", "<CMD>colder<CR>", { desc = "Go to previous Quickfix List" })
vim.keymap.set("n", "<leader>wd", function()
  vim.diagnostic.setqflist()
  vim.cmd.copen()
end, { desc = "Open Workspace Quickfix Diagnostics" })

-- Loclist
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>")
vim.keymap.set("n", "<leader>ld", function()
  vim.diagnostic.setloclist()
  vim.cmd.lopen()
end, { desc = "Open File Diagnostics" })

-- Tmux
vim.keymap.set("n", "<C-f>", "<CMD>silent !tmux neww tmux-sessionizer<CR>")
