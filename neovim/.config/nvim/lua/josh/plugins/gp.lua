return {
  "robitx/gp.nvim",
  event = "VeryLazy",
  config = function()
    local gp = require("gp")
    gp.setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
    })
    vim.keymap.set("n", "<leader>cp", "<CMD>GpChatNew vsplit<CR>", { desc = "" })
  end,
}
