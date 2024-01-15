-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Go to the last buffer" })
vim.keymap.set("n", "dd", "\"_dd", { desc = "Delete line without yanking" })
vim.keymap.set("n", "d", "\"_d", { desc = "Delete to black-hold register" })

-- Clipboard remaps. Leader y to yank to clipbard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+Y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Marks
--
-- Make marks slightly more user friendly.
-- This makes ' behave like ` so that it goes to the column and not the beginning of the line.
vim.keymap.set("n", "'", "`", { desc = "Jump to Mark" })

-- Keep focus in center when moving up or down the page.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allow moving a visual selection up or down a line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--- Quickfix list shortcuts
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Go to previous item in Quickfix List" })
-- Toggle the quickfix list
vim.keymap.set("n", "<leader>co", function()
  local is_open = false
  local win_list = vim.api.nvim_list_wins()

  for _, win in ipairs(win_list) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, "buftype") == "quickfix" then
      is_open = true
      break
    end
  end

  if is_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle the Quickfix list" })
