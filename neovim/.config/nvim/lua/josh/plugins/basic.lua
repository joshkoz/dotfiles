return {
  {
    "tpope/vim-commentary",
    event = "BufEnter",
  },
  -- {
  --   "numToStr/Comment.nvim",
  --   config = true,
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
  -- automatically guess and set shiftwidth for the buffer
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "tpope/vim-surround",
    event = "BufEnter",
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   enabled = false,
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     local autopairs = require("nvim-autopairs")
  --
  --     autopairs.setup({
  --       check_ts = true,
  --     })
  --
  --     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --
  --     local cmp = require("cmp")
  --
  --     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --   end,
  -- },
}
