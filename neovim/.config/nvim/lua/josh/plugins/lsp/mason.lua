return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
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
  config = function(_, opts)
    pcall(require, "mason-nvim-dap")

    local mason = require("mason");
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls
    local mason_null_ls = require("mason-null-ls")

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
        'jsonls',
        'rust_analyzer',
        'tsserver',
        'html',
        'omnisharp',
        'lua_ls',
        'cssls',
        'emmet_ls',
        'pylsp',
        'pyright',
      },
      automatic_installation = true
    })

    mason_null_ls.setup({
      -- list of formatters & linters for mason to install
      ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua",   -- lua formatter
        "eslint_d", -- ts/js linter
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true,
    })
  end
}
