require("oil").setup({
  columns = {},
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-p>"] = false,
    ["<C-l>"] = false,
    ["_"] = false,
  },
})

vim.keymap.set({ "n", "v" }, "-", "<CMD>Oil<CR>", { silent = true, desc = "Open the parent directory" })
