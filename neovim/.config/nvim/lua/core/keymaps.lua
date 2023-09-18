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
--

-- Marks
--
-- Make marks slightly more user friendly.
-- This makes ' behave like ` so that it goes to the column and not the beginning of the line.
vim.keymap.set('n', "'",
  function()
    local mark_char = vim.fn.nr2char(vim.fn.getchar())
    if mark_char:match("%l") then -- If the mark is a lowercase letter
      mark_char = mark_char:upper()
    end
    vim.cmd(string.format("normal! `%s", mark_char))
  end,
  { desc = "Jump to Mark" })

-- Capital letter marks are global by default. Since I only really use one mark at a time
-- It works better if all marks just behave as global.
local opts = { noremap = true, silent = true }
for _, letter in ipairs({ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
  't', 'u', 'v', 'w', 'x', 'y', 'z' }) do
  vim.api.nvim_set_keymap('n', 'm' .. letter, 'm' .. letter:upper(), opts)
end

--- Quickfix list shortcuts
vim.keymap.set('n', '<leader>co', function()
  local is_open = false
  local win_list = vim.api.nvim_list_wins()

  for _, win in ipairs(win_list) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
      is_open = true
      break
    end
  end

  if is_open then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end, { desc = "Toggle the Quickfix list" })
vim.keymap.set('n', '<leader>cn', "<cmd>cnext<CR>", { desc = "Go to next item in Quickfix List" })
vim.keymap.set('n', ']q', "<cmd>cnext<CR>", { desc = "Go to next item in Quickfix List" })
vim.keymap.set('n', '<leader>cp', "<cmd>cprev<CR>", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set('n', '[q', "<cmd>cprev<CR>", { desc = "Go to previous item in Quickfix List" })
