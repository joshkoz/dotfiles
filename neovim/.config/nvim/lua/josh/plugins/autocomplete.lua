return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v0.*",
    opts = {
      keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        list = {
          selection = "manual",
        },
      },
      providers = {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default", "lazydev" },
  },
}
