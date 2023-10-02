return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = 'BufEnter',
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle [E]xplorer" },
    {
      "<leader>o",
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end,
      desc = "Toggle F[o]cus Explorer"
    }
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true
      },
      filtered_items = {
        hide_dotfiles = false,
      }
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
      }
    }
  }
}
