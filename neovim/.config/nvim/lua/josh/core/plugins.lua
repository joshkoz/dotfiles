vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/cbochs/grapple.nvim",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.notify",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.clue",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/seblj/roslyn.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  -- "https://github.com/mfussenegger/nvim-lint",
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
require("josh.plugins.grapple")
-- require("josh.plugins.linting")
require("josh.plugins.mini")
require("josh.plugins.oil")
require("josh.plugins.roslyn")
require("josh.plugins.smart-splits")
require("josh.plugins.snacks")
require("josh.plugins.treesitter")
