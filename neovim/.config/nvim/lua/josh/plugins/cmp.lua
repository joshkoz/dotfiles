return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-path", -- source from filesystem paths
      "hrsh7th/cmp-buffer", -- source from strings in buffer
      "hrsh7th/cmp-nvim-lsp", -- source from lsp
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
      {
        -- Snippets
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip", -- source from snippet engine
        },
      },
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.setup({})
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        completion = {
          keyword_length = 2,
        },
        ---@diagnostic disable-next-line: missing-fields
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          -- ["<C-j>"] = cmp.mapping.select_next_item(),
          -- ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "lazydev", group_index = 0 },
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        list = {
          selection = "manual",
        },
        documentation = {
          auto_show = true,
        },
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },
}
