local function refresh_fugitive()
  -- We need to sleep to allow for changes to happen in the fs before refreshing
  vim.cmd('sleep 100m')
  -- Check if the fugitive buffer is open
  -- Refresh it if it is.
  local buf_list = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buf_list) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if string.match(buf_name, 'fugitive://') then
      -- If the fugitive buffer is found, force an update on it.
      vim.api.nvim_buf_call(buf, function()
        vim.cmd('silent! e')
      end)
      break
    end
  end
end


return {
  {
    'tpope/vim-fugitive',
    event = 'BufEnter',
    keys = {
      {
        "<leader>gg",
        function()
          local fugitive_win_id = nil
          local buf_list = vim.api.nvim_list_bufs()

          for _, buf in ipairs(buf_list) do
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if string.match(buf_name, 'fugitive://') then
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
            vim.cmd('vert Git')
          end
        end,
        desc = "Open [G]it Fugitive"
      },
      {
        "<leader>gs",
        function()
          local gitsigns = require 'gitsigns';
          gitsigns.stage_hunk()
          refresh_fugitive()
        end,
        desc = "[G]it [S]tage Hunk"
      },
      {
        "<leader>gr",
        function()
          local gitsigns = require 'gitsigns';
          gitsigns.reset_hunk()
          refresh_fugitive()
        end,
        desc = "[G]it [R]eset Hunk"
      }
    }
  },
  'tpope/vim-rhubarb',
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[G]it Preview [H]unk' })
      end
    }
  }
}
