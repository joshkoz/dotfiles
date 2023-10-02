return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = 'Telescope',
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")
    telescope.load_extension('fzf')
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "^.git/",
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
        },
        mappings = {
          n = { q = actions.close },
          i = {
            ["<esc>"] = actions.close,
            ["jj"] = { "<esc>", type = "command" },
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })
  end,
  keys = {
    { 'gr', function() require('telescope.builtin').lsp_references() end, desc = '[G]oto [R]eferences' },
    {
      '<leader>lu',
      function() require('telescope.builtin').lsp_references() end,
      desc = '[L]SP: Find [U]sages'
    },
    {
      '<leader>ls',
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = '[L]SP Document [S]ymbols'
    },
    {
      '<leader>fs',
      function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
      desc = '[F]ind [S]ymbols'
    },
    {
      '<leader>fp',
      function() require('telescope.builtin').git_files({ show_untracked = true }) end,
      desc =
      '[F]ind Git [P]roject Files'
    },
    {
      '<C-p>',
      function()
        local exit_code = os.execute('git rev-parse --is-inside-work-tree > /dev/null 2>&1')
        local ok = exit_code == 0
        print(ok)
        if ok then
          require 'telescope.builtin'.git_files({ show_untracked = true })
        else
          require 'telescope.builtin'.find_files({ hidden = true })
        end
      end,
      desc = 'Smart Search [F]iles'
    },
    {
      '<C-f>',
      function() require('telescope.builtin').live_grep() end,
      desc = 'Grep Project'
    },
    {
      '<leader>ff',
      function() require('telescope.builtin').find_files({ hidden = true }) end,

      desc =
      '[F]ind [F]iles'
    },
    {
      '<leader>fr',
      function() require('telescope.builtin').oldfiles() end,
      desc = '[F]ind [R]ecent files'
    },
    {
      '<leader>fh',
      function() require('telescope.builtin').help_tags() end,
      desc = '[F]ind [H]elp'
    },
    {
      '<leader>fc',
      function() require('telescope.builtin').grep_string() end,
      desc = '[F]ind string under [C]ursor'
    },
    {
      '<leader>fg',
      function() require('telescope.builtin').live_grep() end,
      desc =
      '[F]ind [G]rep'
    },
    {
      '<leader>fd',
      function() require('telescope.builtin').diagnostics() end,
      desc =
      '[F]ind [D]iagnostics'
    },
    {
      '<leader>?',
      function() require('telescope.builtin').oldfiles() end,
      desc = '[?] Find recently opened files'
    },
    {
      '<leader>b',
      function() require('telescope.builtin').buffers() end,
      desc = 'Find existing [b]uffers'
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
