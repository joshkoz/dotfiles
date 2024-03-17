return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git", -- also try out "git_branch"
    icons = true, -- setting to "true" requires "nvim-web-devicons"
    status = true,
  },
  keys = {
    { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
    { "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

    { "<A-q>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<A-w>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<A-e>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<A-r>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
    { "<A-t>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

    { "<c-s-p>", "<cmd>Grapple cycle backward<cr>", desc = "Go to previous tag" },
    { "<c-s-n>", "<cmd>Grapple cycle forward<cr>", desc = "Go to next tag" },
  },
}
