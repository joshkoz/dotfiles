--
-- Highlight on yank
--
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--
-- Remove quickfix items
--
local qf_remove_item_group = vim.api.nvim_create_augroup("QfRemoveItemsGroup", { clear = true })
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

vim.api.nvim_create_user_command("RemoveQFItems", function(range)
  Remove_qf_items(vim.fn.line("'<"), vim.fn.line("'>"))
end, { range = true })

-- Autocommands for key mappings in 'qf' filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = qf_remove_item_group,
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "dd", ":RemoveQFItem<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "x", "dd", ":RemoveQFItems<CR>", { noremap = true, silent = true })
  end,
})

local theme_overrides_group = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })

--
-- Create the autocmd for the Colorscheme event
--
vim.api.nvim_create_autocmd("Colorscheme", {
  callback = function()
    -- Ensure splits dont have a background color
    vim.cmd.hi("VertSplit guibg=NONE")
    vim.cmd.hi("HorizSplit guibg=NONE")
    -- Ensure that the onedark theme NeoTree Area seperator
    if vim.g.colors_name == "onedark" then
      vim.api.nvim_command("highlight link NeoTreeWinSeparator WinSeparator")
    end
    -- Hide the status line
    vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
    vim.api.nvim_command("highlight link MyStatusLine WinSeparator")
  end,
  group = theme_overrides_group,
  pattern = "*",
})
