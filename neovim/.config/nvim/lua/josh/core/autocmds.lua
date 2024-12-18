-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal textwidth=72 colorcolumn=50,72 formatexpr=",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", {}),
  callback = function(ev)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.lsp.buf.definition()" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.diagnostic.setqflist()" })
    vim.keymap.set("n", "grh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.lsp.inlay_hint.toggle()" })
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
