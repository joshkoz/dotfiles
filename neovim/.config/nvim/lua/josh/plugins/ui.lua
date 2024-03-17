vim.g.colorscheme = "catppuccin"

return {
  -- Show notifications in the corner
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- region Have hex codes show their color
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
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "letieu/harpoon-lualine",
    },
    config = function()
      -- LSP clients attached to buffer
      local clients_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()
        ---@diagnostic disable-next-line: deprecated
        local clients = vim.lsp.buf_get_clients(bufnr)
        if next(clients) == nil then
          return ""
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return "\u{f085} " .. table.concat(c, "|")
      end

      local custom_auto = require("lualine.themes.auto")
      custom_auto.normal.c.bg = "None"
      custom_auto.normal.b.bg = "None"
      custom_auto.insert.b.bg = "None"
      custom_auto.replace.b.bg = "None"
      custom_auto.visual.b.bg = "None"
      custom_auto.command.b.bg = "None"

      require("lualine").setup({
        options = {
          theme = custom_auto,
          icons_enabled = true,
          globalstatus = true,
          component_separators = "|",
          always_divide_middle = true,
          section_separators = "",
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "branch", icon = "" }, "filename" },
          lualine_c = {
            {
              "harpoon2",
              icon = "♥",
              indicators = { "1", "2", "3", "4" },
              active_indicators = { "[1]", "[2]", "[3]", "[4]" },
            },
          },
          lualine_x = { { "diagnostics", symbols = { error = " ", warn = " ", info = " " }, colored = false }, "diff", "filetype" },
          lualine_y = { "progress", "location" },
          lualine_z = { clients_lsp },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
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
