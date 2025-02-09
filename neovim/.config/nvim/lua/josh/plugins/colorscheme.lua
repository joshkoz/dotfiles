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
  -- {
  --   "rose-pine/neovim",
  --   priority = 1000,
  --   name = "rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       styles = {
  --         italic = false,
  --         transparency = true,
  --       },
  --     })
  --     vim.cmd("colorscheme rose-pine")
  --   end,
  -- },
}
