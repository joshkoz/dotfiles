require("grapple").setup({
  scope = "git", -- also try out "git_branch"
  icons = true, -- setting to "true" requires "nvim-web-devicons"
  status = true,
  win_opts = {
    border = "rounded",
    title_pos = "center",
    footer = "",
  },
})

local map = vim.keymap.set

map("n", "<leader>a", "<cmd>Grapple toggle<cr>", { desc = "Tag a file" })
map("n", "<c-e>", "<cmd>Grapple toggle_tags<cr>", { desc = "Toggle tags menu" })

-- Index-based selection
map("n", "<A-q>", "<cmd>Grapple select index=1<cr>", { desc = "Select tag 1" })
map("n", "<A-w>", "<cmd>Grapple select index=2<cr>", { desc = "Select tag 2" })
map("n", "<A-e>", "<cmd>Grapple select index=3<cr>", { desc = "Select tag 3" })
map("n", "<A-r>", "<cmd>Grapple select index=4<cr>", { desc = "Select tag 4" })
map("n", "<A-t>", "<cmd>Grapple select index=5<cr>", { desc = "Select tag 5" })
map("n", "<A-y>", "<cmd>Grapple select index=1<cr>", { desc = "Select tag 1" })
map("n", "<A-u>", "<cmd>Grapple select index=2<cr>", { desc = "Select tag 2" })
map("n", "<A-i>", "<cmd>Grapple select index=3<cr>", { desc = "Select tag 3" })
map("n", "<A-o>", "<cmd>Grapple select index=4<cr>", { desc = "Select tag 4" })
map("n", "<A-p>", "<cmd>Grapple select index=5<cr>", { desc = "Select tag 5" })
