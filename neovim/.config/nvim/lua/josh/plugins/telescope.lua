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

    opts.desc = "[F]ind [D]iagnostics"
    vim.keymap.set("n", "<leader>d", builtins.diagnostics, opts)

    opts.desc = "Fuzzy Find [H]elp Tags"
    vim.keymap.set("n", "<leader>h", builtins.help_tags, opts)

    opts.desc = "Fuzzy Find [M]arks"
    vim.keymap.set("n", "<leader>m", builtins.marks, opts)

    opts.desc = "Fuzzy Find [B]uffers"
    vim.keymap.set("n", "<leader>b", builtins.buffers, opts)

    opts.desc = "Grep The Project"
    vim.keymap.set("n", "<leader>t", function()
      builtins.live_grep({ hidden = true })
    end, opts)

    opts.desc = "Smart Search Files"
    vim.keymap.set("n", "<C-p>", smart_find, opts)

    opts.desc = "[S]earch Files"
    vim.keymap.set("n", "<leader>s", smart_find, { desc = "[S]earch Files" })
  end,
}
