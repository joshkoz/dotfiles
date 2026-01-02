vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame -w -C -C -C<CR>", { desc = "[G]it [B]lame" })
vim.keymap.set("n", "<leader>dp", "<cmd>DiffviewFileHistory<cr>", { desc = "[D]iff view [p]roject history" })
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "[D]iff view [f]ile history" })
vim.keymap.set("v", "<leader>dr", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = "[D]iff visual [r]ange" })
vim.keymap.set("n", "<leader>ds", "<cmd>DiffviewOpen<cr>", { desc = "[D]iff against HEAD" })

local function get_default_branch_name()
  local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
  return res.code == 0 and "main" or "master"
end

-- Diff against local master branch
vim.keymap.set("n", "<leader>dm", function()
  vim.cmd("DiffviewOpen " .. get_default_branch_name())
end, { desc = "[D]iff against " .. get_default_branch_name() })

-- Diff against remote master branch
vim.keymap.set("n", "<leader>dM", function()
  vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
end, { desc = "[D]iff against origin/" .. get_default_branch_name() })
