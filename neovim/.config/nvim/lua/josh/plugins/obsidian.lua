---@diagnostic disable: missing-fields
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  event = {
    "BufReadPre /home/joshua/vaults/work-vault/**.md",
    "BufReadPre /home/joshua/vaults/second-brain/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("obsidian").setup({
      disable_frontmatter = true,
      completion = { nvim_cmp = true },
      daily_notes = {
        folder = "📅 Journal",
      },
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "Second Brain",
          path = "/home/joshua/vaults/second-brain/",
        },
        {
          name = "Work Vault",
          path = "/home/joshua/vaults/work-vault/",
        },
      },
    })
  end,
}
