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

-- [[ Autoformatting on save ]]
-- Switch for controlling whether you want autoformatting.
--  Use :FormatOnSaveToggle to toggle autoformatting on save on or off
local format_is_enabled = true

vim.api.nvim_create_user_command('FormatOnSaveToggle', function()
  format_is_enabled = not format_is_enabled
  print('Setting autoformatting to: ' .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
  if not _augroups[client.id] then
    local group_name = 'lsp-format-' .. client.name
    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
    _augroups[client.id] = id
  end

  return _augroups[client.id]
end

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
  -- This is where we attach the autoformatting for reasonable clients
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    -- Only attach to clients that support document formatting
    if not client.server_capabilities.documentFormattingProvider then
      return
    end

    -- Tsserver usually works poorly. Sorry you work with bad languages
    -- You can remove this line if you know what you're doing :)
    -- if client.name == 'tsserver' then
    --   return
    -- end

    -- Create an autocmd that will run *before* we save the buffer.
    --  Run the formatting command for the LSP that has just attached.
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = get_augroup(client),
      buffer = bufnr,
      callback = function()
        if not format_is_enabled then
          return
        end

        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        }
      end,
    })
  end,
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
