return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {} },
    'Hoffs/omnisharp-extended-lsp.nvim',
    'simrat39/rust-tools.nvim',
    'williamboman/mason.nvim',
    { 'williamboman/mason-lspconfig.nvim', opts = {} },
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
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
    local lspconfig = require 'lspconfig'

    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- Setup keymaps for when when an LSP attaches to the buffer.
      opts.desc = '[L]SP: [R]ename'
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

      opts.desc = '[L]SP: Code [A]ction'
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

      opts.desc = 'LSP: [G]oto [D]efinition'
      vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

      opts.desc = 'LSP: [G]oto [R]eferences'
      vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

      opts.desc = 'LSP: [G]oto [I]mplementation'
      vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

      opts.desc = '[L]SP: [T]ype Definition'
      vim.keymap.set('n', '<leader>lt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

      opts.desc = 'LSP: Hover Documentation'
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- See `:help K` for why this keymap

      opts.desc = 'Show buffer diagnostics'
      vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- See `:help K` for why this keymap

      opts.desc = '[L]SP: [S]ignature Documentation'
      vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)

      opts.desc = 'LSP: [G]oto [D]eclaration'
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      opts.desc = 'Open floating diagnostic message'
      vim.keymap.set('n', 'gh', vim.diagnostic.open_float, opts)

      opts.desc = '[L]SP: List [D]iagnostics'
      vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist, opts)

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configure html server
    lspconfig['html'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- configure typescript server with plugin
    lspconfig['tsserver'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- configure css server
    lspconfig['cssls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['jsonls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- configure lua server
    lspconfig['lua_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.stdpath 'config' .. '/lua'] = true,
            },
          },
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = { enable = false },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }

    -- configure pylsp server
    lspconfig['pyright'].setup {}
    -- configure pylsp server
    -- lspconfig['pylsp'].setup {
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         pycodestyle = {
    --           ignore = { 'W391' },
    --           maxLineLength = 100,
    --         },
    --       },
    --     },
    --   },
    -- }
    --
    -- configure omnisharp server
    lspconfig['omnisharp'].setup {
      cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
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
        enable_roslyn_analyzers = true,
      },
      handlers = {
        -- https://github.com/Hoffs/omnisharp-extended-lsp.nvim
        ['textDocument/definition'] = require('omnisharp_extended').handler,
        -- Make warning the minimum level shown for csharp
        ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = {
            severity_limit = 'Warning',
          },
        }),
      },
    }

    -- configure rust server using rust-tools
    require('rust-tools').setup {
      tools = {
        inlay_hints = {
          auto = true,
          parameter_hints_prefix = '<-',
          other_hints_prefix = '->',
        },
        server = {
          standalone = false,
        },
        dap = function()
          local install_root_dir = vim.fn.stdpath 'data' .. '/mason'
          local extension_path = install_root_dir .. '/packages/codelldb/extension/'
          local codelldb_path = extension_path .. 'adapter/codelldb'
          local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

          return {
            adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
          }
        end,
      },
      server = {
        on_attach = on_attach,
        settings = {
          -- List of all options:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ['rust-analyzer'] = {},
        },
      },
    }
  end,
}
