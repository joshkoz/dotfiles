local pick = require("mini.pick")

local function format_path_item(item)
  local path

  if type(item) == "string" then
    path = item
  elseif type(item) == "table" and type(item.path) == "string" then
    path = item.path
  end

  if path == nil then
    return item
  end

  local name = vim.fn.fnamemodify(path, ":t")
  local display = string.format("%s  %s", name, path)

  if type(item) == "table" then
    return vim.tbl_deep_extend("force", item, { text = display })
  end

  return { text = display, path = path }
end

local function show_filename_first(buf_id, items, query, opts)
  local formatted = vim.tbl_map(format_path_item, items)
  return pick.default_show(buf_id, formatted, query, opts)
end

pick.setup({
  options = {
    use_cache = true,
  },
  window = {
    config = {
      border = "solid",
    },
    -- config = function()
    --   local height = math.floor(0.618 * vim.o.lines)
    --   local width = math.floor(0.618 * vim.o.columns)
    --   return {
    --     anchor = "NW",
    --     height = height,
    --     width = width,
    --     row = math.floor(0.5 * (vim.o.lines - height)),
    --     col = math.floor(0.5 * (vim.o.columns - width)),
    --     border = "solid",
    --   }
    -- end,
  },
  mappings = {
    stop = "<Esc>",
    sendtoqf = {
      char = "<C-q>",
      func = function()
        local mappings = pick.get_picker_opts().mappings
        vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
      end,
    },
  },
})

vim.keymap.set("n", "<c-p>", function()
  pick.builtin.files({ tool = "git" }, { source = { show = show_filename_first } })
end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>f", function()
  pick.builtin.files({}, { source = { show = show_filename_first } })
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>h", pick.builtin.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live, { desc = "Find Live Grep" })
