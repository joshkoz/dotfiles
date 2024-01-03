return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      log_level = 'info',
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
      auto_session_last_session_dir = '', -- unused
      auto_session_enabled = true,
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
      pre_save_cmds = { 'Neotree close' },
      pre_restore_cmds = { 'Neotree toggle' },
    }

    vim.keymap.set('n', '<leader>sr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' }) -- restore last workspace session for current directory
    vim.keymap.set('n', '<leader>sw', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' }) -- save workspace session for current working directory
  end,
}
