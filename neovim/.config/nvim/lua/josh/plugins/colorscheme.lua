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
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#15141A",
            mantle = "#15141A",
            -- crust = "#15141A",
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
}
