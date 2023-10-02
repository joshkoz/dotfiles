-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Define a Lua function to remove the items from the quickfix list
function remove_qf_items(start_line, end_line)
  -- Get all items in the quickfix list
  local qfall = vim.fn.getqflist()

  -- Remove the items from the quickfix list
  -- Loop backwards to preserve the indices of the items to be removed
  for i = end_line, start_line, -1 do
    table.remove(qfall, i)
  end

  -- Replace the quickfix list with the updated list
  vim.fn.setqflist(qfall, 'r')

  -- Reopen the quickfix window
  vim.cmd('copen')
end

-- Create commands to call the Lua function
vim.cmd('command! RemoveQFItem lua remove_qf_items(vim.fn.line("."), vim.fn.line("."))')
vim.cmd('command! -range RemoveQFItems lua remove_qf_items(vim.fn.line("\'<"), vim.fn.line("\'>"))')

-- Set up an autocommand to map 'dd' to remove the quickfix item(s) when the
-- filetype is 'qf' (quickfix)
vim.cmd('autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<CR>')
vim.cmd('autocmd FileType qf xnoremap <buffer> dd :RemoveQFItems<CR>')
