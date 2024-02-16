-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>pv", "<cmd>Ex .<CR>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--vim.keymap.set("v", "<leader>s", ":s/\\%V\\(.*\\)\\%V/(&)/<left><left>", { desc = "test" })
vim.keymap.set("v", "<leader>s", ":s/\\%V.*\\%V/(&)", { desc = "Wrap selection with" })

-- vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>", { desc = "Go to the last buffer" })
vim.keymap.set("n", "dd", "\"_dd", { desc = "Delete line without yanking" })
vim.keymap.set("n", "d", "\"_d", { desc = "Delete to black-hold register" })

-- Clipboard remaps. Leader y to yank to clipbard
vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set({ "v", "n" }, "<leader>p", "\"+p")

-- Allow moving a visual selection up or down a line
vim.keymap.set("v", "K", ":m '<-2<CR>gvgv=gv") -- weird timing bug with only gv=gv for more than 3 lines selected
vim.keymap.set("v", "J", ":m '>+1<CR>gvgv=gv")

-- Buffers
vim.keymap.set("n", "]b", "<cmd>bnext<CR>zz", { desc = "Go to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<CR>zz", { desc = "Go to previous buffer" })

-- Diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

--- Quickfix
-- vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Go to next item in Quickfix List" })
-- vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Go to previous item in Quickfix List" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Go to next item in Quickfix List" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Go to previous item in Quickfix List" })

-- Toggle the quickfix list
vim.keymap.set("n", "<leader>cc", function()
  local is_open = false
  local win_list = vim.api.nvim_list_wins()

  for _, win in ipairs(win_list) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "quickfix" then
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

-- 3 Way diff get left or right side
vim.keymap.set("n", "<leader>gh", "<cmd>diffget  //2<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>diffget  //3<CR>")
