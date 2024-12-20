return {
  { "nvim-lua/plenary.nvim" },
  { "nmac427/guess-indent.nvim", opts = {} },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
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
    "echasnovski/mini.hipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "mcauley-penney/visual-whitespace.nvim",
    branch = "getregionpos", -- Remove this branch
    config = function()
      require("visual-whitespace").setup()
      local comment_fg = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg#")
      local visual_bg = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg#")
      vim.api.nvim_set_hl(0, "VisualNonText", { fg = comment_fg, bg = visual_bg })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      indent = {
        enabled = true,
        animate = { enabled = false },
        chunk = { enabled = false },
        scope = { enabled = true, hl = "LineNr", char = "│" },
        -- scope = { enabled = true, hl = "Comment", char = "│" },
        indent = {
          char = "┆", -- | ¦ ┆ ┊ │
          hl = "LineNr",
        },
      },
      scope = { enabled = false },
      input = {
        enabled = true,
        icon = "",
        win = {
          wo = {
            winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:FloatBorder,SnacksInputBorder:FloatBorder",
          },
          border = "rounded",
          style = "minimal",
          title_pos = "left",
          relative = "cursor",
          row = -3,
          col = 0,
          keys = {
            v_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n" },
            i_esc = { "<esc>", "stopinsert", mode = "i" },
          },
        },
      },
      notifier = {
        enabled = true,
        top_down = false,
        style = "minimal",
        margin = { bottom = 2 },
      },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true, left = { "mark", "sign" }, right = { "fold", "git" } },
      words = { enabled = false },
    },
  },
}
