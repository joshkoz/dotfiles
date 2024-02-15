return {
  -- Show notifications in the corner
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- region Have hex codes show their color
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    config = true,
  },
  -- Have todo comments highlight
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  -- Add indentation guides even on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        enabled = false,
      },
    },
  },
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "warmer",
      })
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "bluz71/vim-nightfly-guicolors",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("vscode").setup({
        italic_comments = true,
        disabale_nvimtree_bg = false,
      })
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
}
