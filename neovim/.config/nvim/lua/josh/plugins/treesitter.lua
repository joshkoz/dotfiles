return {
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
      treesitter.setup({
        modules = {},
        sync_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 10000
          end, -- Disable if the buffer is too large
          additional_vim_regex_highlighting = { "markdown" },
        },
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "toml",
          "html",
          "css",
          "c",
          "cpp",
          "lua",
          "python",
          "rust",
          "tsx",
          "vimdoc",
          "vim",
          "bash",
          "c_sharp",
          "markdown",
          "markdown_inline",
          "dockerfile",
          "gitignore",
        },
        auto_install = true,
        indent = { enable = true },
        incremental_selection = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
  -- {
  --   "folke/ts-comments.nvim",
  --   opts = {},
  --   event = "VeryLazy",
  --   enabled = vim.fn.has("nvim-0.10.0") == 1,
  -- },
}
