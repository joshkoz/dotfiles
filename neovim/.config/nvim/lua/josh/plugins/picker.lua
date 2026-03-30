local pick = require("mini.pick")

pick.setup({
  options = {
    use_cache = true,
  },
  window = {
    config = {
      border = "solid",
    },
    -- config = function()
    --   local height = math.floor(0.618 * vim.o.lines)
    --   local width = math.floor(0.618 * vim.o.columns)
    --   return {
    --     anchor = "NW",
    --     height = height,
    --     width = width,
    --     row = math.floor(0.5 * (vim.o.lines - height)),
    --     col = math.floor(0.5 * (vim.o.columns - width)),
    --     border = "solid",
    --   }
    -- end,
  },
  mappings = {
    stop = "<Esc>",
    sendtoqf = {
      char = "<C-q>",
      func = function()
        local mappings = pick.get_picker_opts().mappings
        vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
      end,
    },
  },
})

vim.keymap.set("n", "<c-p>", function()
  pick.builtin.files({ tool = "git" })
end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>f", pick.builtin.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>h", pick.builtin.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live, { desc = "Find Live Grep" })
