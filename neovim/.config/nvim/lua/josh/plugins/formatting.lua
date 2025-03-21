return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier", "eslint" },
          javascriptreact = { "prettier", "eslint" },
          typescriptreact = { "prettier", "eslint" },
          typescript = { "prettier", "eslint" },
          json = { "prettier", "eslint" },
          css = { "prettier" },
          html = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          cs = { "csharpier" },
        },
        format = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_fallback = true,
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
          quiet = true, -- If there's a syntax error we don't want to report an error
        },
      })
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
