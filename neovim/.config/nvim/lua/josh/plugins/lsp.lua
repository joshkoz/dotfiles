return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")

      lspconfig["html"].setup({
        capabilities = capabilities,
      })

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

      lspconfig["marksman"].setup({
        capabilities = capabilities,
      })

      lspconfig["bashls"].setup({
        capabilities = capabilities,
      })

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                "${3rd}/luv/library",
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = { enable = false },
            codeLens = {
              enable = true,
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "snacks.nvim",
        "lazy.nvim",
        "blink.nvim",
      },
    },
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
