vim.g.colorscheme = "catppuccin"

return {
  -- Show notifications in the corner
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- region Have hex codes show their color
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = { "BufReadPre", "BufNewFile" },
  --   enabled = true,
  --   config = true,
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
    },
  },
  -- Have todo comments highlight
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "BufEnter",
    enabled = true,
    opts = {
      input = {
        insert_only = false,
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "bluz71/vim-nightfly-guicolors",
    },
    config = function()
      local custom_auto = require("lualine.themes.auto")
      custom_auto.normal.c.bg = "None"
      custom_auto.normal.b.bg = "None"
      custom_auto.insert.b.bg = "None"
      custom_auto.replace.b.bg = "None"
      custom_auto.visual.b.bg = "None"
      custom_auto.command.b.bg = "None"
      --
      require("lualine").setup({
        options = {
          theme = custom_auto,
          icons_enabled = true,
          globalstatus = true,
          component_separators = "|",
          section_separators = "",
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
        },
      })
    end,
  },
  -- Add indentation guides even on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    enabled = false,
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
    lazy = true,
    config = function() end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  {
    "bluz71/vim-nightfly-guicolors",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    config = function()
      require("vscode").setup({
        italic_comments = true,
        disabale_nvimtree_bg = false,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {},
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
