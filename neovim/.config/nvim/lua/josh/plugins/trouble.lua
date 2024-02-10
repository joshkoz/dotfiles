return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- https://github.com/folke/trouble.nvim
  },
  config = function()
    local trouble = require("trouble")
    vim.keymap.set("n", "<leader>xx", function()
      trouble.toggle()
    end, { desc = "Toggle Diagnostics" })
    vim.keymap.set("n", "<leader>xw", function()
      trouble.toggle("workspace_diagnostics")
    end, { desc = "Toggle Workspace Diagnostics" })
    vim.keymap.set("n", "<leader>xd", function()
      trouble.toggle("document_diagnostics")
    end, { desc = "Toggle Document Diagnostics" })
    vim.keymap.set("n", "<leader>xq", function()
      trouble.toggle("quickfix")
    end, { desc = "Toggle Quickfix Diagnostics" })
    vim.keymap.set("n", "<leader>xl", function()
      trouble.toggle("loclist")
    end, { desc = "Toggle Loclist Diagnostics" })
    vim.keymap.set("n", "gR", function()
      trouble.toggle("lsp_references")
    end, { desc = "Toggle LSP References Diagnostics" })
  end,
}
