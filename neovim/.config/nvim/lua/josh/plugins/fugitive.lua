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
      vim.keymap.set("n", "<leader>gs", toggle_fugitive_status, { desc = "[G]it Status" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame -w -C -C -C<CR>", { desc = "[G]it [B]lame" })
      vim.keymap.set("n", "<leader>gh", "<cmd>0Gclog<CR>", { desc = "[G]it [H]istory for buffer" })
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
      end,
    },
  },
}
