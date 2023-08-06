-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  [""] = {
    ["<C-j>"] = { "<S-}>", desc = "Jump to next empty line" },
    ["<C-k>"] = { "<S-{>", desc = "Jump to previous empty line" },
    ["<C-.>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" }, -- Ctrl+. comes through as ^N
    ["<C-n>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
    ["<S-j>"] = { function() vim.cmd "wincmd j" end, desc = "Move split focus down" },
    ["<S-k>"] = { function() vim.cmd "wincmd k" end, desc = "Move split focus up" },
    ["<S-h>"] = { function() vim.cmd "wincmd h" end, desc = "Move split focus left" },
    ["<S-l>"] = { function() vim.cmd "wincmd l" end, desc = "Move split focus right" },
  },
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader><leader>"] = { "<cmd>b#<cr>", desc = "Go to the last buffer" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },

    dd = { '"_dd', desc = "Delete line without yanking" },
    d = { '"_d', desc = "Delete to black-hole register" },
    gh = { function() vim.lsp.buf.hover() end, desc = "Hover diagnostics" },
    gd = { function() vim.lsp.buf.definition() end, desc = "Go to definition" },
    gs = { function() vim.lsp.buf.signature_help() end, desc = "Signature Help" },
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<C-P>"] = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    ["<C-f>"] = { "<cmd>Telescope live_grep<cr>", desc = "Search across all files" },
    ["<C-W>"] = { ":bd<Cr>", desc = "Close Buffer" },
    -- ["<C-B>"] = { "<cmd>Telescope buffers<cr>", desc = "Find buffers" }, // tmux/zellij replaces ctrl b
    ["<C-j>"] = { "<S-}>", desc = "Jump to next empty line" },
    ["<C-k>"] = { "<S-{>", desc = "Jump to previous empty line" },
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    ["<C-j>"] = { "<S-}>", desc = "Jump to next empty line" },
    ["<C-k>"] = { "<S-{>", desc = "Jump to previous empty line" },
  },
  t = {
    ["<C-j>"] = { "<S-}>", desc = "Jump to next empty line" },
    ["<C-k>"] = { "<S-{>", desc = "Jump to previous empty line" },
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
