return {
  {
    "tpope/vim-fugitive",
    event = "BufEnter",
    config = function()
      -- Keymaps
      vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "[G]it Status" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame -w -C -C -C<CR>", { desc = "[G]it [B]lame" })
      vim.keymap.set("n", "<leader>gd", function()
        vim.cmd("tabedit %")
        vim.cmd("Gdiff")
        vim.cmd("norm ]czt")
      end, { desc = "[G]it [D]iff" })
    end,
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        vim.keymap.set("n", "]n", function()
          gitsigns.nav_hunk("next")
        end, { buffer = bufnr, desc = "Go to Next Hunk" })
        vim.keymap.set("n", "[n", function()
          gitsigns.nav_hunk("prev")
        end, { buffer = bufnr, desc = "Go to Previous Hunk" })
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "[G]it [P]review Hunk" })
        vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, { buffer = bufnr, desc = "[G]it [A]dd Hunk" })
        vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "[G]it [U]ndo Stage Hunk" })
        vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "[G]it [R]eset Hunk" })
        vim.keymap.set("n", "<leader>gq", gitsigns.setqflist, { desc = "[G]it add changes to quickfix list" })
        vim.keymap.set("n", "<leader>gd", function()
          gitsigns.toggle_linehl()
          gitsigns.toggle_deleted()
          gitsigns.toggle_word_diff()
        end, { desc = "Toggle word diff" })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    enabled = false,
    config = function()
      vim.keymap.set("n", "<leader>dp", "<cmd>DiffviewFileHistory<cr>", { desc = "[D]iff view [p]roject history" })
      vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "[D]iff view [f]ile history" })
      vim.keymap.set("v", "<leader>dr", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = "[D]iff file [r]ange" })
      vim.keymap.set("n", "<leader>ds", "<cmd>DiffviewOpen<cr>", { desc = "[D]iff against HEAD" })
      local function get_default_branch_name()
        local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
        return res.code == 0 and "main" or "master"
      end

      -- Diff against local master branch
      vim.keymap.set("n", "<leader>dm", function()
        vim.cmd("DiffviewOpen " .. get_default_branch_name())
      end, { desc = "[D]iff against master" })

      -- Diff against remote master branch
      vim.keymap.set("n", "<leader>dM", function()
        vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
      end, { desc = "[D]iff against origin/master" })
    end,
  },
}
