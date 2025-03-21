return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    -- dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    opts = function(_, opts)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
      return {
        keymap = {
          preset = "default",
          ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        completion = {
          accept = { auto_brackets = { enabled = false } },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }, { "source_name" } },
            },
          },
          documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = true },
        },
        signature = { enabled = true },
        cmdline = {
          enabled = false,
          keymap = {
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        sources = {
          default = {
            -- "lazydev",
            "lsp",
            "path",
            -- "snippets",
            "buffer",
          },
          providers = { },
        },
      }
    end,
    opts_extend = { "sources.default" },
  },
}
