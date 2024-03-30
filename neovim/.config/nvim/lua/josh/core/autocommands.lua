-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf, noremap = true, silent = true }

    opts.desc = "[L]SP: [R]ename"
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

    opts.desc = "[L]SP: Code [A]ction"
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

    opts.desc = "LSP: [G]oto [D]efinition"
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "LSP: [G]oto [D]eclaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "LSP: [G]oto [R]eferences"
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "LSP: [G]oto [I]mplementation"
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "LSP: Hover Documentation"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Open floating diagnostic message"
    vim.keymap.set("n", "gh", vim.diagnostic.open_float, opts)

    opts.desc = "[L]SP: Add [D]iagnostics Quickfix"
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, opts)

    opts.desc = "[L]SP: Add References to Quickfix list"
    vim.keymap.set("n", "<leader>lc", vim.lsp.buf.references, opts)
  end,
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

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.Build.props",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})
