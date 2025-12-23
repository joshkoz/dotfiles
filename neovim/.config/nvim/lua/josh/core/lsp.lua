vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("vtsls")
vim.lsp.enable("marksman")
vim.lsp.enable("sqruff")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("joshkoz/lsp-Keymaps", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}
      -- for i = 32, 126 do
      --   table.insert(chars, string.char(i))
      -- end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, noremap = true, silent = true, desc = "vim.lsp.buf.definition()" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, noremap = true, silent = true, desc = "vim.lsp.buf.declaration()" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = args.buf, noremap = true, silent = true, desc = "vim.lsp.buf.implementation()" })
    vim.keymap.set("n", "grh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { buffer = args.buf, noremap = true, silent = true, desc = "vim.lsp.inlay_hint.toggle()" })
  end,
})
