return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        list = {
          selection = function(ctx)
            return ctx.mode == "cmdline" and "auto_insert" or "manual"
          end,
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = true },
      },
      signature = { enabled = true },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        cmdline = {},
        -- cmdline = function()
        --   local type = vim.fn.getcmdtype()
        --   -- Search forward and backward
        --   if type == "/" or type == "?" then
        --     return { "buffer" }
        --   end
        --   -- Commands
        --   if type == ":" then
        --     return { "cmdline" }
        --   end
        --   return {}
        -- end,

        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
