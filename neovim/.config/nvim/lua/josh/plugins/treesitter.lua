return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  config = function()
    local file_types = {
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
    }
    require("nvim-treesitter").install(file_types)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = file_types,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
