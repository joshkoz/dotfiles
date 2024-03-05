return {
  "stevearc/oil.nvim",
  opts = {},
  enabled = false,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
      },
      columns = {},
      keymaps = {
        -- These are the default keymaps
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        -- ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        -- ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        -- ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        -- non default keymaps
        ["<esc>"] = "actions.close",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
    })
    -- keymaps
    vim.keymap.set("n", "<leader>e", oil.open, { desc = "Toggle [E]xplorer" })
    vim.keymap.set("n", "<leader>o", function()
      oil.open(".")
    end, { desc = "Toggle [E]xplorer at Current Working Directory" })
  end,
}
