-- require("mini.surround").setup({})
-- require("mini.ai").setup({})

local hipatterns = require("mini.hipatterns")
vim.api.nvim_set_hl(0, "JoshHipatternsImportant", { fg = "#FFFF00", underline = true })
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsFixme" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    important = { pattern = "%f[%w]()IMPORTANT()%f[%W]", group = "JoshHipatternsImportant" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local minidiff = require("mini.diff")
minidiff.setup({
  view = {
    style = "sign",
    signs = {
      add = "▎",
      change = "▎",
      delete = "",
      topdelete = "",
      changedelete = "▎",
      untracked = "▎",
    },
    priority = 199,
  },
})
vim.keymap.set("n", "<leader>dh", function()
  minidiff.toggle_overlay(0)
end, { desc = "Git Diff Hunk Preview" })

require("mini.notify").setup({
  window = {
    winblend = 100,
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
      return {
        anchor = "SE",
        col = vim.o.columns,
        row = vim.o.lines - pad,
        border = "none",
      }
    end,
  },
})

require("mini.icons").setup({
  file = {
    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
  },
  filetype = {
    dotenv = { glyph = "", hl = "MiniIconsYellow" },
  },
})

-----------------------------------------------------------
-- 4. Mini.clue & Keymaps
-----------------------------------------------------------

-- local miniclue = require("mini.clue")
-- vim.api.nvim_set_hl(0, "MiniClueDescSingle", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "MiniClueDescGroup", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "MiniClueNextKey", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "MiniClueBorder", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "MiniClueTitle", { link = "Title" })
--
-- miniclue.setup({
--   window = {
--     config = { border = "rounded", width = 50, style = "minimal" },
--   },
--   triggers = {
--     { mode = "n", keys = "<Leader>" },
--     { mode = "x", keys = "<Leader>" },
--     { mode = "i", keys = "<C-x>" },
--     { mode = "n", keys = "g" },
--     { mode = "x", keys = "g" },
--     { mode = "n", keys = "'" },
--     { mode = "n", keys = "`" },
--     { mode = "x", keys = "'" },
--     { mode = "x", keys = "`" },
--     { mode = "n", keys = "\"" },
--     { mode = "x", keys = "\"" },
--     { mode = "i", keys = "<C-r>" },
--     { mode = "c", keys = "<C-r>" },
--     { mode = "n", keys = "<C-w>" },
--     { mode = "n", keys = "z" },
--     { mode = "x", keys = "z" },
--   },
--   clues = {
--     miniclue.gen_clues.builtin_completion(),
--     miniclue.gen_clues.g(),
--     miniclue.gen_clues.marks(),
--     miniclue.gen_clues.registers(),
--     miniclue.gen_clues.windows(),
--     miniclue.gen_clues.z(),
--   },
-- })
