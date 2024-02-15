---@diagnostic disable: missing-fields
return {
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
    },
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
        auto_tag = { enable = true },
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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/playground",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        textobjects = {
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              ["ak"] = "@block.outer",
              ["ik"] = "@block.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["a?"] = "@conditional.outer",
              ["i?"] = "@conditional.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]k"] = { query = "@block.outer", desc = "Next block start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]a"] = { query = "@parameter.outer", desc = "Next parameter start" },
            },
            goto_next_end = {
              ["]k"] = { query = "@block.outer", desc = "Next block end" },
              ["]c"] = { query = "@class.outer", desc = "Next class end" },
              ["]f"] = { query = "@function.outer", desc = "Next function end" },
              ["]a"] = { query = "@parameter.outer", desc = "Next parameter end" },
            },
            goto_previous_start = {
              ["[k"] = { query = "@block.outer", desc = "Previous block start" },
              ["[c"] = { query = "@class.outer", desc = "Previous class start" },
              ["[f"] = { query = "@function.outer", desc = "Previous function start" },
              ["[a"] = { query = "@parameter.outer", desc = "Previous parameter start" },
            },
            goto_previous_end = {
              ["[K"] = { query = "@block.outer", desc = "Previous block end" },
              ["[C"] = { query = "@class.outer", desc = "Previous class end" },
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[A"] = { query = "@parameter.outer", desc = "Previous parameter end" },
            },
          },
        },
      })
    end,
  },
}
