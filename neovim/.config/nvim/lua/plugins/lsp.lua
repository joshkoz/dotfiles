local servers = {
  jsonls = {},
  rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { 'html' } },
  omnisharp = {
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

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      "Hoffs/omnisharp-extended-lsp.nvim",
      "mason.nvim",
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
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
      -- Automatically format on save
      autoformat = true,
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
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = servers,
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>lh', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          local config = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes
          }

          if server_name == "omnisharp" then
            config.handlers = {
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
          end

          require('lspconfig')[server_name].setup(config)
        end
      }

      -- -- Switch for controlling whether you want autoformatting.
      -- --  Use :KickstartFormatToggle to toggle autoformatting on or off
      -- local format_is_enabled = true
      -- vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      --   format_is_enabled = not format_is_enabled
      --   print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      -- end, {})
      --
      -- -- Create an augroup that is used for managing our formatting autocmds.
      -- --      We need one augroup per client to make sure that multiple clients
      -- --      can attach to the same buffer without interfering with each other.
      -- local _augroups = {}
      -- local get_augroup = function(client)
      --   if not _augroups[client.id] then
      --     local group_name = 'kickstart-lsp-format-' .. client.name
      --     local id = vim.api.nvim_create_augroup(group_name, { clear = true })
      --     _augroups[client.id] = id
      --   end
      --
      --   return _augroups[client.id]
      -- end
      --
      -- -- Whenever an LSP attaches to a buffer, we will run this function.
      -- --
      -- -- See `:help LspAttach` for more information about this autocmd event.
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      --   -- This is where we attach the autoformatting for reasonable clients
      --   callback = function(args)
      --     local client_id = args.data.client_id
      --     local client = vim.lsp.get_client_by_id(client_id)
      --     local bufnr = args.buf
      --
      --     -- Only attach to clients that support document formatting
      --     if not client.server_capabilities.documentFormattingProvider then
      --       return
      --     end
      --
      --     -- Tsserver usually works poorly. Sorry you work with bad languages
      --     -- You can remove this line if you know what you're doing :)
      --     if client.name == 'tsserver' then
      --       return
      --     end
      --
      --     -- Create an autocmd that will run *before* we save the buffer.
      --     --  Run the formatting command for the LSP that has just attached.
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       group = get_augroup(client),
      --       buffer = bufnr,
      --       callback = function()
      --         if not format_is_enabled then
      --           return
      --         end
      --
      --         vim.lsp.buf.format {
      --           async = false,
      --           filter = function(c)
      --             return c.id == client.id
      --           end,
      --         }
      --       end,
      --     })
      --   end,
      -- })
    end,
  },
  { 'williamboman/mason-lspconfig.nvim', opts = {} }
}
