return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = "VimEnter",
  config = function()
    local actions = require "telescope.actions"
    require('telescope').setup {
      defaults = {
        mappings = {
          n = { q = actions.close },
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }
  end,
  keys = {
    { 'gr', function() require('telescope.builtin').lsp_references() end, desc = '[G]oto [R]eferences' },
    {
      '<leader>ds',
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = '[D]ocument [S]ymbols'
    },
    {
      '<leader>ws',
      function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
      desc = '[W]orkspace [S]ymbols'
    },
    {
      '<leader>gf',
      function() require('telescope.builtin').git_files() end,
      desc =
      'Search [G]it [F]iles'
    },
    {
      '<C-p>',
      function()
        local exit_code = os.execute('git rev-parse --is-inside-work-tree > /dev/null 2>&1')
        local ok = exit_code == 0
        print(ok)
        if ok then
          require 'telescope.builtin'.git_files()
        else
          require 'telescope.builtin'.find_files()
        end
      end,
      desc = 'Search [G]it [F]iles'
    },
    {
      '<C-f>',
      function() require('telescope.builtin').live_grep() end,
      desc = 'Search [G]it [F]iles'
    },
    {
      '<leader>ff',
      function() require('telescope.builtin').find_files() end,

      desc =
      'Search [G]it [F]iles'
    },
    {
      '<leader>sh',
      function() require('telescope.builtin').help_tags() end,
      desc = '[S]earch [H]elp'
    },
    {
      '<leader>sw',
      function() require('telescope.builtin').grep_string() end,
      desc = '[S]earch current [W]ord'
    },
    {
      '<leader>sg',
      function() require('telescope.builtin').live_grep() end,
      desc =
      '[S]earch by [G]rep'
    },
    {
      '<leader>sd',
      function() require('telescope.builtin').diagnostics() end,
      desc =
      '[S]earch [D]iagnostics'
    },
    {
      '<leader>?',
      function() require('telescope.builtin').oldfiles() end,
      desc = '[?] Find recently opened files'
    },
    {
      '<leader>b',
      function() require('telescope.builtin').buffers() end,
      desc = '[ ] Find existing buffers'
    },
    {
      '<leader>/',
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer'
    }
  }
}
