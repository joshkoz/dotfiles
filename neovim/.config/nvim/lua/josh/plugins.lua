vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.notify",
  "https://github.com/nvim-mini/mini.icons",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^6") },
  "https://github.com/folke/snacks.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- set color scheme early
require("josh.plugins.colorscheme")

---@diagnostic disable-next-line: duplicate-set-field
package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

require("josh.plugins.autocomplete")
require("josh.plugins.formatting")
require("josh.plugins.git")
require("josh.plugins.mini")
require("josh.plugins.oil")
-- require("josh.plugins.smartsplits")
require("josh.plugins.snacks")
require("josh.plugins.treesitter")
