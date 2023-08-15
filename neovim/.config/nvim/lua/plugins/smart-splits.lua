return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile" },
  },
  keys = {
    { '<C-h>',     function() require('smart-splits').move_cursor_left() end,  desc = "Move to left split" },
    { '<C-j>',     function() require('smart-splits').move_cursor_down() end,  desc = "Move to below split" },
    { '<C-k>',     function() require('smart-splits').move_cursor_up() end,    desc = "Move to above split" },
    { '<C-l>',     function() require('smart-splits').move_cursor_right() end, desc = "Move to right split" },
    { '<C-Up>',    function() require('smart-splits').resize_up() end,         desc = "Resize split up" },
    { '<C-Down>',  function() require('smart-splits').resize_down() end,       desc = "Resize split down" },
    { '<C-Left>',  function() require('smart-splits').resize_left() end,       desc = "Resize split left" },
    { '<C-Right>', function() require('smart-splits').resize_right() end,      desc = "Resize split right" }
  }
}
