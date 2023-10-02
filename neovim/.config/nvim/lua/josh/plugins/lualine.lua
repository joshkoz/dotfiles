return
{
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      globalstatus = true,
      component_separators = '|',
      section_separators = '',
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
    }
  }
}
