return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  event = {
    "BufReadPre /home/joshua/vaults/work-journal/**.md",
    "BufReadPre /home/joshua/vaults/second-brain/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "hrsh7th/nvim-cmp",
  },
  opts = {
    disable_frontmatter = true,
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
        path = "/home/joshua/vaults/work-journal/",
      },
    },
  },
}
