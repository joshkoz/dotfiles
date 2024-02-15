return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  event = "BufEnter",
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")
    local telescopebuiltin = require("telescope.builtin")
    telescope.load_extension("fzf")
    telescope.setup({
      defaults = {
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
        mappings = {
          n = { q = actions.close },
          i = {
            ["<esc>"] = actions.close,
            ["jj"] = { "<esc>", type = "command" },
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    })

    -- keymaps
    vim.keymap.set("n", "gr", telescopebuiltin.lsp_references, { desc = "[G]oto [R]eferences" })
    vim.keymap.set("n", "<leader>lu", telescopebuiltin.lsp_references, { desc = "[L]SP: Find [U]sages" })
    vim.keymap.set("n", "<leader>ls", telescopebuiltin.lsp_document_symbols, { desc = "[L]SP Document [S]ymbols" })
    vim.keymap.set("n", "<leader>fs", telescopebuiltin.lsp_dynamic_workspace_symbols, { desc = "[F]ind [S]ymbols" })
    vim.keymap.set("n", "<leader>fp", function()
      telescopebuiltin.git_files({ show_untracked = true })
    end, { desc = "[F]ind Git [P]roject Files" })
    vim.keymap.set("n", "<C-f>", telescopebuiltin.live_grep, { desc = "Grep Project" })
    vim.keymap.set("n", "<leader>ff", function()
      telescopebuiltin.find_files({ hidden = true })
    end, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>'", telescopebuiltin.marks, { desc = "Find [M]arks" })
    vim.keymap.set("n", "<leader>;", telescopebuiltin.marks, { desc = "Find [M]arks" })
    vim.keymap.set("n", "<leader>fr", telescopebuiltin.oldfiles, { desc = "[F]ind [R]ecent files" })
    vim.keymap.set("n", "<leader>fh", telescopebuiltin.help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>fc", telescopebuiltin.grep_string, { desc = "[F]ind string under [C]ursor" })
    vim.keymap.set("n", "<leader>fg", telescopebuiltin.live_grep, { desc = "[F]ind [G]rep" })
    vim.keymap.set("n", "<leader>fd", telescopebuiltin.diagnostics, { desc = "[F]ind [D]iagnostics" })
    vim.keymap.set("n", "<leader>?", telescopebuiltin.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader>b", telescopebuiltin.buffers, { desc = "Find existing [b]uffers" })
    vim.keymap.set("n", "<leader>ct", telescopebuiltin.colorscheme, { desc = "[C]hange [T]heme" })
    vim.keymap.set("n", "<C-p>", function()
      local exit_code = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
      local ok = exit_code == 0
      if ok then
        telescopebuiltin.git_files({ show_untracked = true })
      else
        telescopebuiltin.find_files({ hidden = true })
      end
    end, { desc = "Smart Search [F]iles" })
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      telescopebuiltin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
  end,
}
