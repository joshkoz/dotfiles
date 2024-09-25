return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    local oil = require("oil")

    oil.setup({
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false, -- "actions.select_split",
        ["<C-p>"] = false, -- "actions.preview",
        ["<C-l>"] = false, --"actions.refresh",
      },
    })

    vim.keymap.set({ "n", "v" }, "-", "<CMD>Oil<CR>", { silent = true, desc = "Open the parent directory" })
  end,
}
