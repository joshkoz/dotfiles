return {
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
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
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#0d1117",
            mantle = "#0d1117",
            crust = "#0d1117",
          },
        },
        highlight_overrides = {
          mocha = function(colors)
            return {
              WinSeparator = { fg = "#363646" },
            }
          end,
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    -- priority = 1000,
    config = function()
      vim.g.nightflyWinSeparator = 2
      -- vim.cmd.colorscheme("nightfly")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    name = "nightfly",
    lazy = true,
    opts = {},
  },
}
