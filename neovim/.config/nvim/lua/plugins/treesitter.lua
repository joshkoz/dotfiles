return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
  },
  event = { "BufReadPost", "BufNewFile" },
  build = ':TSUpdate',
  opts = {
    -- Add languages to be installed here that you want installed for treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    ensure_installed = {
      'c', 'cpp', 'lua',
      'python', 'rust', 'tsx',
      'typescript', 'vimdoc', 'vim',
      'c_sharp', 'markdown', 'html'
    },

    auto_install = true,

    highlight = {
      enable = true,
      disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end, -- Disable if the buffer is too large
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["ak"] = "@block.outer",
          ["ik"] = "@block.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["a?"] = "@conditional.outer",
          ["i?"] = "@conditional.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]k"] = { query = "@block.outer", desc = "Next block start" },
          ["]c"] = { query = "@class.outer", desc = "Next class start" },
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]a"] = { query = "@parameter.outer", desc = "Next parameter start" },
        },
        goto_next_end = {
          ["]k"] = { query = "@block.outer", desc = "Next block end" },
          ["]c"] = { query = "@class.outer", desc = "Next class end" },
          ["]f"] = { query = "@function.outer", desc = "Next function end" },
          ["]a"] = { query = "@parameter.outer", desc = "Next parameter end" },
        },
        goto_previous_start = {
          ["[k"] = { query = "@block.outer", desc = "Previous block start" },
          ["[c"] = { query = "@class.outer", desc = "Previous class start" },
          ["[f"] = { query = "@function.outer", desc = "Previous function start" },
          ["[a"] = { query = "@parameter.outer", desc = "Previous parameter start" },
        },
        goto_previous_end = {
          ["[K"] = { query = "@block.outer", desc = "Previous block end" },
          ["[C"] = { query = "@class.outer", desc = "Previous class end" },
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[A"] = { query = "@parameter.outer", desc = "Previous parameter end" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [">k"] = { query = "@block.outer", desc = "Swap next block" },
          [">f"] = { query = "@function.outer", desc = "Swap next function" },
          [">a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
        },
        swap_previous = {
          ["<k"] = { query = "@block.outer", desc = "Swap previous block" },
          ["<f"] = { query = "@function.outer", desc = "Swap previous function" },
          ["<a"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
        },
      },
    },
  }
}
