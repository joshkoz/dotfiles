return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opt = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
      { "antosha417/nvim-lsp-file-operations", config = true },
      "williamboman/mason.nvim",
      "seblj/roslyn.nvim",
      -- {
      --   dir = "/home/joshua/projects/roslyn.nvim",
      -- },
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
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = ev.buf, noremap = true, silent = true }

          opts.desc = "Hover Documentation"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Will be a default in new versions of Neovim.
          opts.desc = "[C]ode [R]efactor Re[n]ame"
          vim.keymap.set("n", "crn", vim.lsp.buf.rename, opts)

          -- Will be a default in new versions of Neovim.
          opts.desc = "[C]ode [R]efactor Action"
          vim.keymap.set("n", "crr", vim.lsp.buf.code_action, opts)

          -- Will be a default in new versions of Neovim.
          opts.desc = "[G]oto [R]eferences"
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

          opts.desc = "[G]oto [D]efinition"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          opts.desc = "[G]oto [D]eclaration"
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "[G]oto [I]mplementation"
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
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

      lspconfig["biome"].setup({
        capabilities = capabilities,
      })

      lspconfig["pyright"].setup({
        capabilities = capabilities,
      })

      lspconfig["dockerls"].setup({
        capabilities = capabilities,
      })
      lspconfig["yamlls"].setup({
        capabilities = capabilities,
      })

      lspconfig["emmet_ls"].setup({
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

      lspconfig["marksman"].setup({
        capabilities = capabilities,
      })

      lspconfig["bashls"].setup({
        capabilities = capabilities,
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

      require("roslyn").setup({
        exe = {
          "dotnet",
          vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
        },
        config = {
          on_attach = function()
            vim.cmd([[compiler dotnet]])
          end,
          settings = {
            ["csharp|inlay_hints"] = {
              ["csharp_enable_inlay_hints_for_implicit_object_creation"] = true,
              ["csharp_enable_inlay_hints_for_implicit_variable_types"] = true,
              ["csharp_enable_inlay_hints_for_lambda_parameter_types"] = true,
              ["csharp_enable_inlay_hints_for_types"] = true,
              ["dotnet_enable_inlay_hints_for_indexer_parameters"] = true,
              ["dotnet_enable_inlay_hints_for_literal_parameters"] = true,
              ["dotnet_enable_inlay_hints_for_object_creation_parameters"] = true,
              ["dotnet_enable_inlay_hints_for_other_parameters"] = true,
              ["dotnet_enable_inlay_hints_for_parameters"] = true,
              ["dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix"] = true,
              ["dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name"] = true,
              ["dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent"] = true,
            },
          },
        },
      })
    end,
  },
  -- {
  --   "iabdelkareem/csharp.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim", -- Required, automatically installs omnisharp
  --     "mfussenegger/nvim-dap",
  --     "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  --     { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  --   },
  --   opts = {
  --     lsp = {
  --       on_attach = function(_, bufnr)
  --         local omnisharp = require("omnisharp_extended")
  --         vim.keymap.set("n", "gd", function()
  --           omnisharp.telescope_lsp_definitions()
  --         end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [D]efinition" })
  --         vim.keymap.set("n", "gI", function()
  --           omnisharp.telescope_lsp_implementation()
  --         end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [I]mplementation" })
  --         vim.keymap.set("n", "gr", function()
  --           omnisharp.telescope_lsp_references()
  --         end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [R]eferences" })
  --       end,
  --       enable_roslyn_analyzers = true,
  --       organize_imports_on_format = true,
  --       enable_import_completion = true,
  --     },
  --   },
  -- },
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
  },
}
