return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
      { "antosha417/nvim-lsp-file-operations", config = true },
      "williamboman/mason.nvim",
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
      code_lens = {
        enabled = true,
      },
      document_highlight = {
        enabled = true,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
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

          -- Will be a default in new versions of Neovim. (See https://github.com/neovim/neovim/pull/28650/files)
          opts.desc = "vim.lsp.buf.rename()"
          vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)

          -- Will be a default in new versions of Neovim. (See https://github.com/neovim/neovim/pull/28650/files)
          opts.desc = "vim.lsp.buf.code_action()"
          vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)

          -- Will be a default in new versions of Neovim. (See https://github.com/neovim/neovim/pull/28650/files)
          opts.desc = "vim.lsp.buf.references()"
          vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)

          opts.desc = "vim.lsp.buf.definition()"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          opts.desc = "vim.lsp.buf.declaration()"
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "vim.lsp.buf.implementation()"
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)

          opts.desc = "LSP: Toggle Inlay Hints"
          vim.keymap.set("n", "gri", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end, opts)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local lspconfig = require("lspconfig")

      -- configure html server
      lspconfig["html"].setup({
        capabilities = capabilities,
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
      })

      lspconfig["jsonls"].setup({
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
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opt = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
      },
      on_attach = function() end,
      settings = {
        separate_diagnostic_server = true,
        tsserver_max_memory = "auto",
        expose_as_code_action = "all",
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
        include_completions_with_insert_text = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
        code_lens = "off",
        jsx_close_tag = {
          enable = false,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
  },
  {
    "seblj/roslyn.nvim",
    opts = {
      -- exe = {
      --   "dotnet",
      --   print(vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"))
      -- },
      -- args = {
      --   "--logLevel=Information",
      --   "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
      -- },
      config = {
        on_attach = function()
          vim.cmd([[compiler dotnet]])
        end,
        settings = {
          ["csharp|symbol_search"] = {
            ["dotnet_search_reference_assemblies"] = true,
          },
          ["csharp|completion"] = {
            ["dotnet_enable_references_code_lens"] = true,
            ["dotnet_show_completion_items_from_unimported_namespaces"] = true,
            ["dotnet_show_name_completion_suggestions"] = true,
          },
          ["csharp|code_lens"] = {
            ["dotnet_enable_references_code_lens"] = true,
            ["dotnet_enable_tests_code_lens"] = true,
          },
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
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
  },
}
