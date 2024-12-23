return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  event = "BufEnter",
  config = function()
    local neotree = require("neo-tree")
    local events = require("neo-tree.events")
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    local opts = {
      window = {
        position = "right",
        width = 50,
      },
      close_if_last_window = false, -- This behaviour sucks. It breaks :bd
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
    }
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    neotree.setup(opts)

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle right<cr>", { desc = "Toggle Neo-Tree" })
  end,
}

-- -- vim.keymap.set("n", "<leader>th", "<CMD>Telescope highlights<CR>");
-- --   vim.api.nvim_set_hl(0, "FloatFooter", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "FloatFooter", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNormalNc", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierError", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierDebug", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTrace", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierBorderInfo", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierBorderDebug", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierBorderTrace", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTitleDebug", { link = "Normal" })
-- --   vim.api.nvim_set_hl(0, "SnacksNotifierTitleTrace", { link = "Normal" })
-- --
-- --
