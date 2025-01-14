vim.diagnostic.config({
  underline = {
    severity = {
      vim.diagnostic.severity.HINT,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
    },
  },
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "▌ ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
  },
})
