return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "jmederosalvarado/roslyn.nvim",
      { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          severity = { min = vim.diagnostic.severity.WARN },
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = false,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    },
    config = function()
      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = ev.buf, noremap = true, silent = true }

          opts.desc = "[L]SP: [R]ename"
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

          opts.desc = "[L]SP: Code [A]ction"
          vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

          opts.desc = "LSP: [G]oto [D]efinition"
          vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

          opts.desc = "LSP: [G]oto [D]eclaration"
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "LSP: [G]oto [R]eferences"
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

          opts.desc = "LSP: [G]oto [I]mplementation"
          vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

          opts.desc = "LSP: Hover Documentation"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          opts.desc = "Open floating diagnostic message"
          vim.keymap.set("n", "gh", vim.diagnostic.open_float, opts)

          opts.desc = "[L]SP: Add [D]iagnostics Quickfix"
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, opts)

          opts.desc = "[L]SP: Add References to Quickfix list"
          vim.keymap.set("n", "<leader>lc", vim.lsp.buf.references, opts)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local lspconfig = require("lspconfig")

      -- configure html server
      lspconfig["html"].setup({
        capabilities = capabilities,
      })

      -- configure typescript server with plugin
      lspconfig["tsserver"].setup({
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
      })

      lspconfig["jsonls"].setup({
        capabilities = capabilities,
      })

      -- configure lua server
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      lspconfig["biome"].setup({
        capabilities = capabilities,
        cmd = { "biome", "lsp-proxy" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "json",
          "jsonc",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
        },
      })

      lspconfig["omnisharp"].setup({
        on_attach = function(_, bufnr)
          local omnisharp = require("omnisharp_extended")
          vim.keymap.set("n", "gd", function()
            omnisharp.telescope_lsp_definitions()
          end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [D]efinition" })
          vim.keymap.set("n", "gI", function()
            omnisharp.telescope_lsp_implementation()
          end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [I]mplementation" })
          vim.keymap.set("n", "gr", function()
            omnisharp.telescope_lsp_references()
          end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [R]eferences" })
        end,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
  },
}
