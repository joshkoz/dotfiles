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
  group = vim.api.nvim_create_augroup("LspProgress", {}),
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

local ns = vim.api.nvim_create_namespace("visual_line_numbers")

vim.api.nvim_create_autocmd({ "ModeChanged", "CursorMoved" }, {
  group = vim.api.nvim_create_augroup("VisualLineNumbers", {}),
  callback = function(args)
    local mode = vim.fn.mode()
    if not mode:match("[vV]") then
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    elseif args.event == "CursorMoved" and mode == "v" or mode == "V" or mode == "" then
      -- -- clear namespace and re-highlight the range
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      -- swap the lines based on if visual selection cursor is at begining or end of visual range
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      vim.api.nvim_buf_set_extmark(0, ns, start_line - 1, 0, {
        end_line = end_line - 1,
        number_hl_group = "CursorLineNr",
      })
    end
  end,
})
