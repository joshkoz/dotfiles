return {
  "echasnovski/mini.clue",
  version = "*",
  dependencies = {
    "nvim-neotest/neotest",
  },
  config = function()
    local miniclue = require("mini.clue")
    vim.api.nvim_set_hl(0, "MiniClueDescSingle", { link = "Normal" })
    vim.api.nvim_set_hl(0, "MiniClueDescGroup", { link = "Normal" })
    vim.api.nvim_set_hl(0, "MiniClueNextKey", { link = "Normal" })
    miniclue.setup({
      window = {
        config = {
          border = "rounded",
          width = 50,
          style = "minimal",
        },
      },
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = "\"" },
        { mode = "x", keys = "\"" },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })
  end,
}
