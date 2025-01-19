return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      sync_install = false,
      ignore_install = {},
      auto_install = true,
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
      modules = {},
      highlight = {
        enable = true,
        -- Disable if the buffer is too large
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
      },
      indent = { enable = true },
    })
  end,
}
