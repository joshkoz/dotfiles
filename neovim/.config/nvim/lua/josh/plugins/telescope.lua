return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  event = "BufEnter",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
        file_ignore_patterns = {
          "^.git/",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    local builtins = require("telescope.builtin")
    local opts = { noremap = true, silent = true }

    -- Keymaps
    opts.desc = "[F]ind [F]iles"
    vim.keymap.set("n", "<leader>f", function()
      builtins.find_files({ hidden = true })
    end, opts)

    opts.desc = "Fuzzy Find [H]elp Tags"
    vim.keymap.set("n", "<leader>h", builtins.help_tags, opts)

    opts.desc = "Live Grep The Project"
    vim.keymap.set("n", "<leader>/", function()
      builtins.live_grep({ hidden = true })
    end, opts)

    opts.desc = "Grep the word under the cursor"
    vim.keymap.set("n", "<leader>sw", function()
      builtins.grep_string({ hidden = true })
    end, opts)

    opts.desc = "Smart Search Files"
    vim.keymap.set("n", "<C-p>", function()
      builtins.git_files({ show_untracked = true })
    end, opts)
  end,
}
