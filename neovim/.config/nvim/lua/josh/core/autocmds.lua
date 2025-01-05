local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal textwidth=72 colorcolumn=50,72 formatexpr=",
})

autocmd("LspAttach", {
  group = augroup("LspKeymaps", { clear = true }),
  callback = function(ev)
    -- vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.lsp.buf.definition()" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.diagnostic.setqflist()" })
    vim.keymap.set("n", "grh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, { buffer = ev.buf, noremap = true, silent = true, desc = "vim.lsp.inlay_hint.toggle()" })
  end,
})

local ns = vim.api.nvim_create_namespace("visual_line_numbers")
autocmd({ "ModeChanged", "CursorMoved" }, {
  group = augroup("VisualLineNumbers", { clear = true }),
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

autocmd("BufEnter", {
  group = augroup("set-spelling", {}),
  pattern = { "*.cs", "*.md", "*.lua" },
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].spell = true
  end,
})
