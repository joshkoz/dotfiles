return {
  "mrjones2014/smart-splits.nvim",
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile" },
  },
  config = function()
    local smartsplits = require("smart-splits")
    vim.keymap.set({ "n", "i" }, "<C-h>", smartsplits.move_cursor_left, { desc = "Move to left split" })
    vim.keymap.set({ "n", "i" }, "<C-j>", smartsplits.move_cursor_down, { desc = "Move to below split" })
    vim.keymap.set({ "n", "i" }, "<C-k>", smartsplits.move_cursor_up, { desc = "Move to above split" })
    vim.keymap.set({ "n", "i" }, "<C-l>", smartsplits.move_cursor_right, { desc = "Move to right split" })
    vim.keymap.set({ "n", "i" }, "<C-Left>", smartsplits.resize_left, { desc = "Resize split left" })
    vim.keymap.set({ "n", "i" }, "<C-Down>", smartsplits.resize_down, { desc = "Resize split down" })
    vim.keymap.set({ "n", "i" }, "<C-Up>", smartsplits.resize_up, { desc = "Move to above up" })
    vim.keymap.set({ "n", "i" }, "<C-Right>", smartsplits.resize_right, { desc = "Resize split right" })
  end,
}
