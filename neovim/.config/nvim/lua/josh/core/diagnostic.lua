vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
  },
})
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Open File Diagnostics" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "Open Workspace Quickfix Diagnostics" })
