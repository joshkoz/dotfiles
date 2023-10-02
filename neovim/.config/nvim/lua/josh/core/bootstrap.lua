-- Bootstrap the lazy.nvim package package manager
--    https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup Plugins
-- Will automatically load plugins from lua/plugins/*lua
require('lazy').setup({
  { import = "josh.plugins" },
  { import = 'josh.plugins.lsp' },
  install = {
    -- try to load one of these colorschemes when starting an installation during startup.
    -- This is the theme for the Lazy UI before everything is set up.
    colorscheme = { "onedark" },
  },
  checker = {
    -- check for updates but don't notify about them on launch
    enabled = true,
    notify = false,
  },
  change_detection = {
    -- don't notify that lazy has reloaded after detecting changes
    notify = false
  }
})