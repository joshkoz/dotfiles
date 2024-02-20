return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-path", -- source from filesystem paths
    "hrsh7th/cmp-buffer", -- source from strings in buffer
    "hrsh7th/cmp-nvim-lsp", -- source from lsp
    "L3MON4D3/LuaSnip", -- Snippet Engine
    "saadparwaiz1/cmp_luasnip", -- source from snippet engine
    "rafamadriz/friendly-snippets", -- source from friendly snippets
  },
  event = "InsertEnter",
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.config.setup({})

    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    }
  end,
}
