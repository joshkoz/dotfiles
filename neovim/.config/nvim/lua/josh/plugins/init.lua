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
      indent = { enabled = false },
      scope = { enabled = false },
      input = {
        enabled = true,
        win = {
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
      notifier = { enabled = true, style = "minimal", top_down = false, margin = { bottom = 2 } },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true, left = { "mark", "sign" }, right = { "fold", "git" } },
      words = { enabled = false },
    },
  },
}
