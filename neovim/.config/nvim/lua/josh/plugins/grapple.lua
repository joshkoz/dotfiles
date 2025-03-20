return {
  {
    "cbochs/grapple.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
      { "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
      { "<A-q>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<A-w>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<A-e>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<A-r>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
      { "<A-t>", "<cmd>Grapple select index=5<cr>", desc = "Select fifth tag" },
      { "<A-y>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<A-u>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<A-i>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<A-o>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
      { "<A-p>", "<cmd>Grapple select index=5<cr>", desc = "Select fifth tag" },
    },
    config = function()
      -- vim.api.nvim_set_hl(0, "GrappleNormal", { link = "Normal" })
      -- vim.api.nvim_set_hl(0, "GrappleBorder", { link = "FzfLuaBorder" })
      -- vim.api.nvim_set_hl(0, "GrappleTitle", { link = "FzfLuaTitle" })
      local opts = {
        scope = "git", -- also try out "git_branch"
        icons = true, -- setting to "true" requires "nvim-web-devicons"
        status = true,
        win_opts = {
          border = "rounded",
          title_pos = "center",
          footer = "",
        },
      }
      require("grapple").setup(opts)
    end,
  },
}
