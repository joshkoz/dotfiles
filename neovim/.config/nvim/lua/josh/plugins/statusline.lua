return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- LSP clients attached to buffer
    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()
      ---@diagnostic disable-next-line: deprecated
      local clients = vim.lsp.get_clients({ bufnr })
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      return "\u{f085} " .. table.concat(c, "|")
    end

    local buildcolor = function()
      local utils = require("lualine.utils.utils")
      local bg = utils.extract_color_from_hllist("bg", { "Normal", "StatusLineNC" }, "None")
      local custom_auto = require("lualine.themes.auto")
      custom_auto.normal.c.bg = bg
      custom_auto.normal.b.bg = bg
      custom_auto.insert.b.bg = bg
      custom_auto.replace.b.bg = bg
      custom_auto.visual.b.bg = bg
      custom_auto.command.b.bg = bg
      return custom_auto
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("lualine_colorscheme_reload", { clear = true }),
      callback = function(ev)
        local lualine = require("lualine")
        local theme = buildcolor()
        -- reload the status line theme, when the theme changes
        lualine.setup({ options = {
          theme = theme,
        } })
      end,
    })

    require("lualine").setup({
      options = {
        theme = buildcolor(),
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
