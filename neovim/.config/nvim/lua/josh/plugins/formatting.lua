return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier', 'eslint' },
        typescript = { 'prettier', 'eslint' },
        javascriptreact = { 'prettier', 'eslint' },
        typescriptreact = { 'prettier', 'eslint' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        terraform = { 'terraform_fmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = '[L]SP: [F]ormat file or range (in visual mode)' })
  end,
}
