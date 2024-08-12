return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
    "MasonUpdate",
    "MasonUpdateAll",
  },
  build = ":MasonUpdate",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "jsonls",
        "rust_analyzer",
        "ts_ls",
        "html",
        "omnisharp",
        "lua_ls",
        "cssls",
        -- "emmet_ls",
        "pyright",
        "omnisharp",
        "biome",
        -- "dockerls",
        "yamlls",
        "marksman",
        -- "bashls",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "csharpier", -- csharp formatter
        "netcoredbg", -- csharp debugger
      },
    })
  end,
}
