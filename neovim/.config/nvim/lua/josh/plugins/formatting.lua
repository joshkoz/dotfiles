require("conform").setup({
  formatters_by_ft = {
    javascript = { "oxfmt", "oxlint" },
    javascriptreact = { "oxfmt", "oxlint" },
    typescriptreact = { "oxfmt", "oxlint" },
    typescript = { "oxfmt", "oxlint" },
    json = { "oxfmt", "eslint" },
    css = { "oxfmt" },
    html = { "oxfmt" },
    yaml = { "oxfmt" },
    markdown = { "oxfmt" },
    lua = { "stylua" },
    python = { "isort", "black" },
    terraform = { "terraform_fmt" },
    cs = { "csharpier" },
    sql = { "sqruff" },
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
