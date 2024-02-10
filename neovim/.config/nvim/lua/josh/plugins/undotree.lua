return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undo tree" })
  end,
}
