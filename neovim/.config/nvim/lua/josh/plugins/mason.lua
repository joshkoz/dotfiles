return {
  "williamboman/mason.nvim",
  cmd = {
    "Mason",
  },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    PATH = "prepend",
    ensure_installed = {
      "html-lsp",
      "css-lsp",
      "json-lsp", -- jsonls
      "lua-language-server",
      "emmet-ls",
      "pyright",
      "biome",
      "dockerfile-language-server", -- dockerls
      "yaml-language-server", -- yamlls
      "marksman",
      "bash-language-server",
      "prettier", -- prettier formatter
      "stylua", -- lua formatter
      "isort", -- python formatter
      "black", -- python formatter
      "pylint", -- python linter
      "eslint_d", -- js linter
      "csharpier", -- csharp formatter
      "netcoredbg", -- csharp debugger
      "clangd",
      "clang-format",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)

    -- AutoInstallation
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
