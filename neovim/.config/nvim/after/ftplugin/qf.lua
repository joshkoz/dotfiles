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

vim.keymap.set("n", "dd", ":RemoveQFItem<CR>", { noremap = true, silent = true, buffer = 0 })
vim.keymap.set("x", "dd", ":RemoveQFItems<CR>", { noremap = true, silent = true, buffer = 0 })
