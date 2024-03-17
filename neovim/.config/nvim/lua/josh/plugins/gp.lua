return {
  "robitx/gp.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>cp", "<CMD>GpChatNew popup<CR>", { desc = "" })
  end,
}
