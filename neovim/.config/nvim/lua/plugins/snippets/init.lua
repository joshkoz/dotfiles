local ls = require "luasnip"

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local function get_solution_name(root_path)
  local sln_file = vim.fn.glob(root_path .. '/*.sln')
  if sln_file == "" then
    return nil
  end

  return vim.fn.fnamemodify(sln_file, ":t:r")
end

local function get_relative_path(root_path, file_path)
  local relative = vim.fn.substitute(file_path, root_path, "", "")
  return vim.fn.fnamemodify(relative, ":r") -- Removes the file extension
end

local function get_csharp_namespace()
  local root_path = vim.fn.getcwd() -- Assuming you're always at the root of the project
  local current_file = vim.fn.expand("%:p")

  local solution_name = get_solution_name(root_path)
  local relative_path = get_relative_path(root_path, current_file)

  if not solution_name then
    print("Could not determine namespace.")
    return
  end
  -- Remove filename from the relative path
  relative_path = vim.fn.fnamemodify(relative_path, ":h")

  local namespace = solution_name .. vim.fn.substitute(relative_path, "/", ".", "g")
  return namespace
end

ls.add_snippets(nil, {
  cs = {
    snip({
      trig = "nsclass",
      namr = "NamespaceClass",
      dscr = "C# Class inside a namespace based on file path",
    }, {
      text "namespace ",
      func(get_csharp_namespace, {}),
      text { ";", "", "internal sealed class " },
      insert(1, "ClassName"),
      text { "", "{", "\t", "}" },
    }),
  },
})

return {}
