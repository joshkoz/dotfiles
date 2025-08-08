return {
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {},
  },
  {
    "echasnovski/mini.hipatterns",
    version = false,
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsFixme" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "echasnovski/mini.diff",
    version = false,
    opts = {
      view = {
        style = "sign",
        -- Signs used for hunks with 'sign' view
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
    },
  },
  {
    "echasnovski/mini.notify",
    version = false,
    opts = {
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
    },
  },
  {
    "echasnovski/mini.icons",
    version = false,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.clue",
    version = false,
    config = function()
      vim.keymap.set("n", "<leader>dh", function()
        MiniDiff.toggle_overlay(0)
      end, { desc = "Git Diff Hunk Preview" })

      local miniclue = require("mini.clue")
      vim.api.nvim_set_hl(0, "MiniClueDescSingle", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MiniClueDescGroup", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MiniClueNextKey", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MiniClueBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MiniClueBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MiniClueTitle", { link = "Title" })
      require("mini.clue").setup({
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
  },
}
