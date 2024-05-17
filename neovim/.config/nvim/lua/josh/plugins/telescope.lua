return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-frecency.nvim",
  },
  commit = "bb96303397a0616e665dbbbb1d7d376cea735de7",
  cmd = "Telescope",
  event = "BufEnter",
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        frecency = {
          ignore_patterns = { "*.git/*", "*/tmp/*", "oil://*", "fugitive://*" },
          db_safe_mode = false,
        },
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
    pcall(telescope.load_extension, "frecency")

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
    opts.desc = "[F]ind [F]iles with Frecency"
    vim.keymap.set("n", "<leader>f", "<Cmd>Telescope frecency workspace=CWD<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<Cmd>Telescope frecency workspace=CWD<CR>", opts)

    opts.desc = "Fuzzy Find [H]elp Tags"
    vim.keymap.set("n", "<leader>h", builtins.help_tags, opts)

    opts.desc = "Live Grep The Project"
    vim.keymap.set("n", "gS", function()
      builtins.live_grep({ hidden = true })
    end, opts)

    opts.desc = "Grep the word under the cursor"
    vim.keymap.set("n", "gss", function()
      builtins.grep_string({ hidden = true })
    end, opts)

    -- <leader>s as a search operator
    require("yop").op_map({ "n", "v" }, "gs", function(lines)
      -- Multiple lines can't be searched for
      if #lines > 1 then
        return
      end
      builtins.grep_string({ search = lines[1], hidden = true })
    end)

    opts.desc = "Smart Search Files"
    vim.keymap.set("n", "<C-p>", smart_find, opts)
  end,
}
