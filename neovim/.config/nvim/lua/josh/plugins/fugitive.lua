return {
  {
    "tpope/vim-fugitive",
    event = "BufEnter",
    config = function()
      local toggle_fugitive_status = function()
        local fugitive_win_id = nil
        local buf_list = vim.api.nvim_list_bufs()

        for _, buf in ipairs(buf_list) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if string.match(buf_name, "fugitive://") then
            -- Find the window ID where this buffer is displayed
            local wins = vim.api.nvim_list_wins()
            for _, win in ipairs(wins) do
              if vim.api.nvim_win_get_buf(win) == buf then
                fugitive_win_id = win
                break
              end
            end
            break
          end
        end

        if fugitive_win_id then
          -- If the Git window is open, close it
          vim.api.nvim_win_close(fugitive_win_id, true)
        else
          -- Otherwise, open it in a vertical split
          vim.cmd("Git")
        end
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "[G]it Status" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame -w -C -C -C<CR>", { desc = "[G]it [B]lame" })
      vim.keymap.set("n", "<leader>gd", function()
        vim.cmd("tabedit %")
        vim.cmd("Gdiff")
        vim.cmd("norm ]czt")
      end, { desc = "[G]it [D]iff" })
      -- vim.keymap.set("n", "<leader>gh", function()
      --   vim.cmd("tabedit %")
      --   vim.cmd("0Gclog")
      -- end, { desc = "[G]it [H]istory" })
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
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        vim.keymap.set("n", "]n", gitsigns.next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
        vim.keymap.set("n", "[n", gitsigns.prev_hunk, { buffer = bufnr, desc = "Go to Previous Hunk" })
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
