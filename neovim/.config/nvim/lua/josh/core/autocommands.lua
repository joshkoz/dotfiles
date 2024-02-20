-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- Remove quickfix items
local function Remove_qf_items(start_line, end_line)
  local qfall = vim.fn.getqflist()
  for i = end_line, start_line, -1 do
    table.remove(qfall, i)
  end
  vim.fn.setqflist(qfall, "r")
  vim.cmd("copen")
end

-- Create commands to call the Lua function
vim.api.nvim_create_user_command("RemoveQFItem", function()
  Remove_qf_items(vim.fn.line("."), vim.fn.line("."))
end, {})

vim.api.nvim_create_user_command("RemoveQFItems", function()
  Remove_qf_items(vim.fn.line("'<"), vim.fn.line("'>"))
end, { range = true })

-- Autocommands for key mappings in 'qf' filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = vim.api.nvim_create_augroup("QfRemoveItemsGroup", { clear = true }),
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "dd", ":RemoveQFItem<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "x", "dd", ":RemoveQFItems<CR>", { noremap = true, silent = true })
  end,
})
