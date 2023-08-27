-- Set space as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


vim.keymap.set('n', '<leader><leader>', "<cmd>b#<cr>", { desc = "Go to the last buffer" })
vim.keymap.set('n', 'dd', '"_dd', { desc = "Delete line without yanking" })
vim.keymap.set('n', 'd', '"_d', { desc = "Delete to black-hold register" })
-- vim.keymap.set('n', "<C-j>", "<S-}>", { desc = "Jump to next empty line" })
-- vim.keymap.set('n', '<C-k>', "<S-{>", { desc = "Jump to previous empty line" })
