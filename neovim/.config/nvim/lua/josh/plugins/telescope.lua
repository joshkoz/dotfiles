return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  event = "BufEnter",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
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

    local builtins = require("telescope.builtin")
    local smart_find = function()
      local exit_code = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
      local ok = exit_code == 0
      if ok then
        builtins.git_files({ show_untracked = true })
      else
        builtins.find_files({ hidden = true })
      end
    end

    local opts = { noremap = true, silent = true }

    -- Keymaps
    opts.desc = "[F]ind [F]iles"
    vim.keymap.set("n", "<leader>f", function()
      builtins.find_files({ hidden = true })
    end, opts)

    opts.desc = "Fuzzy Find [H]elp Tags"
    vim.keymap.set("n", "<leader>h", builtins.help_tags, opts)

    opts.desc = "Live Grep The Project"
    vim.keymap.set("n", "S", function()
      builtins.live_grep({ hidden = true })
    end, opts)

    opts.desc = "Grep the word under the cursor"
    vim.keymap.set("n", "ss", function()
      builtins.grep_string({ hidden = true })
    end, opts)

    opts.desc = "Smart Search Files"
    vim.keymap.set("n", "<C-p>", function()
      builtins.git_files({ show_untracked = true })
    end, opts)
  end,
}
