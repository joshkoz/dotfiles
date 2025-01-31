return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      indent = {
        enabled = true,
        animate = { enabled = false },
        chunk = { enabled = false },
        scope = { enabled = true, hl = "LineNr", char = "│" },
        -- scope = { enabled = true, hl = "Comment", char = "│" },
        indent = {
          char = "┆", -- | ¦ ┆ ┊ │
          -- hl = "LineNr",
        },
      },
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
      },
      scope = { enabled = false },
      input = {
        enabled = false,
        icon = "",
        win = {
          wo = {
            winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:FloatBorder,SnacksInputBorder:FloatBorder",
          },
          border = "rounded",
          style = "minimal",
          title_pos = "left",
          relative = "cursor",
          row = -3,
          col = 0,
          keys = {
            v_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n" },
            i_esc = { "<esc>", "stopinsert", mode = "i" },
          },
        },
      },
      notifier = {
        enabled = true,
        top_down = false,
        style = "minimal",
        margin = { bottom = 2 },
      },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true, left = { "mark", "sign" }, right = { "fold", "git" } },
      words = { enabled = false },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "SnacksNotifierMinimal", { link = "Normal" })

      vim.keymap.set("n", "<c-p>", function()
        Snacks.picker.git_files({})
      end, { desc = "Find Git Files" })

      vim.keymap.set("n", "<leader>f", Snacks.picker.files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>h", Snacks.picker.help, { desc = "Find Help" })
      vim.keymap.set("n", "<leader>e", function()
        Snacks.picker.explorer({ hidden = true })
      end, { desc = "Open Explorer" })
      vim.keymap.set("n", "<leader>u", Snacks.picker.undo, { desc = "Open Undo" })
      vim.keymap.set("n", "<leader>/", function()
        Snacks.picker.grep({ hidden = true, ignored = false })
      end, { desc = "Find Live Grep" })
      vim.keymap.set("n", "<leader>w", Snacks.picker.diagnostics, { desc = "Workspace diagnostics" })
      vim.keymap.set("n", "<leader>j", function()
        Snacks.picker()
      end, { desc = "Find pickers" })
      require("snacks").setup(opts)
    end,
  },
}
