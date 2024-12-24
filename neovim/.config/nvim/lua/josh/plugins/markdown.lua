return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(opts)
      local markview = require("markview")

      markview.setup({
        hybrid_modes = { "n" },
        initial_state = false,
      })
    end,
  },
}
