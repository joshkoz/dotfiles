return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local function js_formatter(bufnr)
      -- Choose the formatter based on the presence of biome.json
      local function has_biome_config()
        local root = vim.fn.getcwd() -- Get the current working directory
        local biome_config_path = root .. "/biome.json" -- Construct the path to biome.json

        return vim.fn.filereadable(biome_config_path) == 1 -- Check if biome.json exists and is readable
      end
      if has_biome_config() then
        return { "biome" } -- Use biome as the formatter
      else
        return { "prettier", "eslint" } -- Default to prettier and eslint
      end
    end

    conform.setup({
      formatters_by_ft = {
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        json = js_formatter,
        css = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        terraform = { "terraform_fmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
        quiet = true, -- If there's a syntax error we don't want to report an erroor
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "[L]SP: [F]ormat file or range (in visual mode)" })
  end,
}
