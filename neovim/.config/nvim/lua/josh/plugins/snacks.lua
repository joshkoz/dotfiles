local snacks = require("snacks")

vim.keymap.set("n", "<c-p>", snacks.picker.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>f", snacks.picker.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>h", snacks.picker.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>e", snacks.picker.explorer, { desc = "Open Explorer" })
vim.keymap.set("n", "<leader>u", snacks.picker.undo, { desc = "Open Undo" })
vim.keymap.set("n", "<leader>/", function()
  snacks.picker.grep({ hidden = true })
end, { desc = "Find Live Grep" })
vim.keymap.set("n", "<leader>w", snacks.picker.diagnostics, { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>j", function()
  snacks.picker()
end, { desc = "Find pickers" })

snacks.setup({
  -- Only using the picker from folke/snacks.
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
                -- require("smart-splits").move_cursor_left()
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
})
snacks.statuscolumn.click_fold = function() end
