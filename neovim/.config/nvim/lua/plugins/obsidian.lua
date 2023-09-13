return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre /mnt/NAS/Second Brain/**.md",
    -- "BufNewFile path/to/my-vault/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",

  },
  config = function(_, opts)
    require('obsidian').setup({
      dir = "/mnt/NAS/Second Brain", -- no need to call 'vim.fn.expand' here
      daily_notes = {
        folder = "📅 Journal",
      },
      completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 2,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        -- Whether to add the output of the node_id_func to new notes in autocompletion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        prepend_note_id = true
      },
      disable_frontmatter = true,
      mappings = {},
      -- mappings = {
      --   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
      -- },
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"open", url})  -- Mac OS
        vim.fn.jobstart({ "xdg-open", url }) -- linux
      end,
    })
    -- Optional, override the 'gf' keymap to utilize obsidian.nvim's search functionality.
    -- see also: 'follow_url_func' config option below.
    vim.keymap.set("n", "gf",
      function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true, desc = "Open the file under the cursor" })
  end
}
