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
  -- {
  --   "j-hui/fidget.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
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
        insert_only = false,
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
