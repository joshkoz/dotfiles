local ns = vim.api.nvim_create_namespace("actionlint")
local timers = {}

local function is_workflow_file(path)
  return path:match("/%.github/workflows/.*%.ya?ml$") ~= nil
end

local function set_diagnostics(bufnr, output)
  local ok, errors = pcall(vim.json.decode, output)
  if not ok or type(errors) ~= "table" then
    return
  end

  local diagnostics = {}
  for _, error in ipairs(errors) do
    local line = math.max((error.line or 1) - 1, 0)
    local col = math.max((error.column or 1) - 1, 0)
    local end_col = error.end_column and math.max(error.end_column - 1, col + 1) or col + 1

    table.insert(diagnostics, {
      lnum = line,
      col = col,
      end_lnum = line,
      end_col = end_col,
      message = error.message,
      severity = vim.diagnostic.severity.ERROR,
      source = "actionlint",
      code = error.kind,
    })
  end

  vim.diagnostic.set(ns, bufnr, diagnostics)
end

local function run_actionlint(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(bufnr)

  if vim.fn.executable("actionlint") ~= 1 or not is_workflow_file(path) then
    vim.diagnostic.reset(ns, bufnr)
    return
  end

  local changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local stdin = table.concat(lines, "\n")

  vim.system({ "actionlint", "-format", "{{json .}}", "-stdin-filename", path, "-" }, { stdin = stdin }, function(result)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_buf_get_changedtick(bufnr) ~= changedtick then
        return
      end

      if result.stdout == "" then
        vim.diagnostic.reset(ns, bufnr)
        return
      end

      set_diagnostics(bufnr, result.stdout)
    end)
  end)
end

local function schedule_actionlint(bufnr)
  local timer = timers[bufnr]
  if timer == nil then
    timer = vim.uv.new_timer()
    timers[bufnr] = timer
  end

  timer:stop()
  timer:start(500, 0, function()
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        run_actionlint(bufnr)
      end
    end)
  end)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
  group = vim.api.nvim_create_augroup("joshkoz/actionlint", { clear = true }),
  pattern = { "*.yml", "*.yaml" },
  callback = function(args)
    schedule_actionlint(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = vim.api.nvim_create_augroup("joshkoz/actionlint-cleanup", { clear = true }),
  callback = function(args)
    local timer = timers[args.buf]
    if timer ~= nil then
      timer:stop()
      timer:close()
      timers[args.buf] = nil
    end
  end,
})
