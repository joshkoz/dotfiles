return {
  {
    priority = 1000,
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        keywordStyle = { italic = false },
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
