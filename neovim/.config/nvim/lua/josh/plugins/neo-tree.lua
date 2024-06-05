return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "BufEnter",
  config = function()
    -- keymaps
    local neotree = require("neo-tree")
    neotree.setup({
      close_if_last_window = true, -- This behaviour sucks. It breaks :bd
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle right<cr>", { desc = "Toggle Neo-Tree" })
  end,
}
