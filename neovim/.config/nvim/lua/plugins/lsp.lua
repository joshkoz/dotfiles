return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'folke/neodev.nvim',                 opts = {} },
    "Hoffs/omnisharp-extended-lsp.nvim",
    'simrat39/rust-tools.nvim',
    "williamboman/mason.nvim",
    { 'williamboman/mason-lspconfig.nvim', opts = {} },
    { 'j-hui/fidget.nvim',                 tag = 'legacy', opts = {} },
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        severity = { min = vim.diagnostic.severity.WARN }
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
    -- Setup keymaps for when when an LSP attaches to the buffer.
    local on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = '[L]SP: [R]ename' })
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L]SP: Code [A]ction' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' })
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Type [D]efinition' })
      -- See `:help K` for why this keymap
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover Documentation' })
      vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help,
        { buffer = bufnr, desc = '[L]SP: [S]ignature Documentation' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' })
      vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- Config for simple LSPs
    local servers = {
      jsonls = {},
      tsserver = {},
      html = { filetypes = { 'html' } },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason-lspconfig').setup({
      ensure_installed = {
        'jsonls',
        'rust_analyzer',
        'tsserver',
        'html',
        'omnisharp',
        'lua_ls'
      },
      handlers = {
        -- default handler. Config from the 'servers' variable is
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes
          })
        end,

        -- Advanced LSP Setup.
        -- see :h mason-lspconfig.setup_handlers
        -- Use opts.servers above for configuration unless the lsp needs custom config.
        rust_analyzer = function()
          require('rust-tools').setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
            tools = {
              inlay_hints = {
                auto = true,
                parameter_hints_prefix = "<-",
                other_hints_prefix = "->",
              },
              server = {
                standalone = false,
              },
              dap = function()
                local install_root_dir = vim.fn.stdpath "data" .. "/mason"
                local extension_path = install_root_dir .. "/packages/codelldb/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

                return {
                  adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
                }
              end,
            },
            server = {
              on_attach = on_attach,
              settings = {
                -- List of all options:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {},
              },

            }
          })
        end,
        omnisharp = function()
          require("lspconfig").omnisharp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
              -- If true, MSBuild project system will only load projects for files that
              -- were opened in the editor. This setting is useful for big C# codebases
              -- and allows for faster initialization of code navigation features only
              -- for projects that are relevant to code that is being edited. With this
              -- setting enabled OmniSharp may load fewer projects and may thus display
              -- incomplete reference lists for symbols.
              enable_ms_build_load_projects_on_demand = false,
              enable_editorconfig_support = true,
              enable_import_completion = true,
              enable_roslyn_analyzers = true
            },
            handlers = {
              -- https://github.com/Hoffs/omnisharp-extended-lsp.nvim
              ["textDocument/definition"] = require('omnisharp_extended').handler,
              -- Make warning the minimum level shown for csharp
              ["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = {
                    severity_limit = 'Warning',
                  },
                })
            }
          })
        end
      }
    })
  end,
}
