return {
  -- automatically guess and set the commentstring
  {
    "numToStr/Comment.nvim",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  -- automatically guess and set shiftwidth for the buffer
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
}
