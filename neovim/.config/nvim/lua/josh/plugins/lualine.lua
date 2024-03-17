return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
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
        component_separators = {},
        always_divide_middle = true,
        section_separators = {},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" }, "filename" },
        lualine_c = {
          "grapple",
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
}
