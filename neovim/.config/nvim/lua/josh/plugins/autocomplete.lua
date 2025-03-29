return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    opts = {
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
          "snippets",
          "buffer",
        },
        providers = {
          lsp = {
            transform_items = function(_, items)
              local cmp_item_kind = require("blink.cmp.types").CompletionItemKind
              local current_buffer_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
              local buffer_text = table.concat(current_buffer_content, "\n")
              for _, item in ipairs(items) do
                -- Initialize score_offset with a base value
                item.score_offset = 0
                local has_label_description = (item.labelDetails and item.labelDetails.description)

                -- Apply prioritization rules
                if item.kind == cmp_item_kind.Method then
                  -- Rule 1: Methods that appear in the current buffer (highest priority)
                  if item.label and buffer_text:find(item.label) then
                    item.score_offset = 50

                    -- Additional boost for methods appearing earlier in the file
                    local first_pos = buffer_text:find(item.label)
                    if first_pos then
                      local position_boost = math.max(5 - (first_pos / 1000), 0)
                      item.score_offset = item.score_offset + position_boost
                    end
                    -- Rule 4: has no label description
                  elseif not has_label_description then
                    item.score_offset = 30
                  -- Rule 3: All other methods (lowest priority)
                  else
                    item.score_offset = 10
                  end
                -- Rule 2: Properties (second highest priority)
                elseif item.kind == cmp_item_kind.Property or item.kind == cmp_item_kind.Field then
                  item.score_offset = 40
                end

                -- Deprioritize operators
                if item.kind == cmp_item_kind.Operator then
                  item.score_offset = item.score_offset - 5
                end
              end

              return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
              end, items)
            end,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
