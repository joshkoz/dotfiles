return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Only using the picker from folke/Snacks.
      picker = {
        ui_select = true,
        formatters = {
          file = {
            filename_first = true, -- display filename before the filepath
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            layout = { layout = { position = "right" } },
            win = {
              list = {
                keys = {
                  ["<ESC>"] = function() end,
                  ["<C-l>"] = function()
                    require("smart-splits").move_cursor_left()
                  end,
                  ["<C-h>"] = function()
                    vim.cmd("wincmd h")
                  end,
                },
              },
            },
          },
          git_files = {
            untracked = true,
          },
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
        },
      },
      statuscolumn = {
        enabled = true,
        left = { "sign" },
        right = { "git" },
      },
    },
    config = function(_, opts)
      vim.keymap.set("n", "<c-p>", Snacks.picker.git_files, { desc = "Find Git Files" })
      vim.keymap.set("n", "<leader>f", Snacks.picker.files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>h", Snacks.picker.help, { desc = "Find Help" })
      vim.keymap.set("n", "<leader>e", Snacks.picker.explorer, { desc = "Open Explorer" })
      vim.keymap.set("n", "<leader>u", Snacks.picker.undo, { desc = "Open Undo" })
      vim.keymap.set("n", "<leader>/", function()
        Snacks.picker.grep({ hidden = true })
      end, { desc = "Find Live Grep" })
      vim.keymap.set("n", "<leader>w", Snacks.picker.diagnostics, { desc = "Workspace diagnostics" })
      vim.keymap.set("n", "<leader>j", function()
        Snacks.picker()
      end, { desc = "Find pickers" })
      require("snacks").setup(opts)
    end,
  },
}
