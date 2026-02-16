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
