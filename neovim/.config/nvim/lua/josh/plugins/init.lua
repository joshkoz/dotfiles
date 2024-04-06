return {
  { "nvim-lua/plenary.nvim" },
  {
    -- Automatically guess and set the commentstring
    -- NOTE: Plugin might not be needed in 0.10 stable with new default gc mapping
    "numToStr/Comment.nvim",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
  },
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
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
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
