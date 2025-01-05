return {
  {
    priority = 1000,
    "rebelot/kanagawa.nvim",
    lazy = false,
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
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        integrations = {
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
        term_colors = true,
        -- transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   enabled = false,
  --   -- priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.cmd.colorscheme("tokyonight-night")
  --   end,
  -- },
  -- {
  --   "bluz71/vim-nightfly-colors",
  --   name = "nightfly",
  --   enabled = false,
  --   lazy = true,
  --   -- priority = 1000,
  --   config = function()
  --     vim.g.nightflyWinSeparator = 2
  --     -- vim.cmd.colorscheme("nightfly")
  --   end,
  -- },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   name = "nightfly",
  --   enabled = false,
  --   lazy = true,
  --   opts = {},
  -- },
}
