return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      -- calling `setup` is optional for customization
      local fzflua = require("fzf-lua")
      local actions = require("fzf-lua.actions")
      fzflua.setup({
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
        },
        defaults = {
          formatter = "path.dirname_first",
        },
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          backdrop = 100,
          border = "rounded",
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
            ["ctrl-q"] = {
              fn = actions.file_edit_or_qf,
              prefix = "select-all+",
            },
          },
        },
        grep = {
          fzf_opts = {
            ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
          },
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
            ["ctrl-q"] = {
              fn = actions.file_edit_or_qf,
              prefix = "select-all+",
            },
          },
        },
        keymap = {
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          },
        },
        lsp = {
          symbols = {
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
            preview_pager = "delta --hunk-header-style omit --file-style omit --file-decoration-style omit",
            winopts = {
              layout = "vertical",
            },
          },
        },
      })
      fzflua.register_ui_select(function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = {
              layout = "vertical",
              vertical = "down:15,border-top",
              -- hidden = "hidden",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end)
      vim.keymap.set("n", "<c-p>", function()
        fzflua.git_files({ cmd = "git ls-files --cached --others --exclude-standard", prompt = "> " })
      end, { desc = "Fzf Git Files" })
      vim.keymap.set("n", "<leader>f", fzflua.files, { desc = "Fzf Files" })
      vim.keymap.set("n", "<leader>h", fzflua.helptags, { desc = "Fzf Help" })
      vim.keymap.set("n", "<leader>/", fzflua.live_grep, { desc = "Fzf Live Grep" })
    end,
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   enabled = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --     "nvim-telescope/telescope-ui-select.nvim",
  --   },
  --   cmd = "Telescope",
  --   event = "BufEnter",
  --   config = function()
  --     local telescope = require("telescope")
  --     telescope.setup({
  --       extensions = {
  --         fzf = {
  --           fuzzy = true,
  --           override_generic_sorter = true,
  --           override_file_sorter = true,
  --           case_mode = "smart_case",
  --         },
  --         ["ui-select"] = {
  --           require("telescope.themes").get_dropdown({}),
  --         },
  --       },
  --       defaults = {
  --         path_display = { "smart" },
  --         mappings = {
  --           i = {
  --             ["<esc>"] = require("telescope.actions").close,
  --           },
  --         },
  --         file_ignore_patterns = {
  --           "^.git/",
  --         },
  --         vimgrep_arguments = {
  --           "rg",
  --           "--color=never",
  --           "--no-heading",
  --           "--with-filename",
  --           "--line-number",
  --           "--column",
  --           "--smart-case",
  --           "--hidden",
  --         },
  --       },
  --     })
  --
  --     pcall(telescope.load_extension, "fzf")
  --     pcall(telescope.load_extension, "ui-select")
  --
  --     local builtins = require("telescope.builtin")
  --     local opts = { noremap = true, silent = true }
  --
  --     -- Keymaps
  --     opts.desc = "[F]ind [F]iles"
  --     vim.keymap.set("n", "<leader>f", function()
  --       builtins.find_files({ hidden = true })
  --     end, opts)
  --
  --     opts.desc = "Fuzzy Find [H]elp Tags"
  --     vim.keymap.set("n", "<leader>h", builtins.help_tags, opts)
  --
  --     opts.desc = "Live Grep The Project"
  --     vim.keymap.set("n", "<leader>/", function()
  --       builtins.live_grep({ hidden = true, debounce = 300 })
  --     end, opts)
  --
  --     opts.desc = "Grep the word under the cursor"
  --     vim.keymap.set("n", "<leader>sw", function()
  --       builtins.grep_string({ hidden = true })
  --     end, opts)
  --
  --     opts.desc = "Smart Search Files"
  --     vim.keymap.set("n", "<C-p>", function()
  --       builtins.git_files({ show_untracked = true })
  --     end, opts)
  --   end,
  -- },
}
