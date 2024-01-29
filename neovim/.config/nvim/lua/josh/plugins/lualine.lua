return {
  -- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "bluz71/vim-nightfly-guicolors",
  },
  enabled = false,
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
}
