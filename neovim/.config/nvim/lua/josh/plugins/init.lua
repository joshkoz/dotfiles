return {
  { "nvim-lua/plenary.nvim" },
  {
    -- Automatically guess and set shiftwidth for the buffer
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
  {
    "echasnovski/mini.notify",
    version = "*",
    config = function()
      local win_config = function()
        local has_statusline = vim.o.laststatus > 0
        local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - bottom_space }
      end
      require("mini.notify").setup({ window = { config = win_config } })
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    -- region Have hex codes show their color
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
        border = "single",
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        border = "single",
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
}
