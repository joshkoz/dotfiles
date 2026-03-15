-- Derived from folke/snacks.nvim (Apache-2.0).
-- Copyright (c) 2024 Folke Lemaitre.
-- Modifications by Joshua.
-- License: Apache-2.0 (see LICENSE/NOTICE for details).

local M = {}
local config = {
  left = { "sign" },
  right = { "git" },
  git = {
    patterns = { "GitSigns", "MiniDiffSign" },
  },
  refresh = 50,
}

local sign_cache = {}
local cache = {}
local icon_cache = {}

local timer = assert((vim.uv or vim.loop).new_timer())
timer:start(config.refresh, config.refresh, function()
  sign_cache = {}
  cache = {}
end)

function M.is_git_sign(name)
  for _, pattern in ipairs(config.git.patterns) do
    if name:find(pattern) then
      return true
    end
  end
end

function M.buf_signs(buf, wanted)
  local signs = {}

  if wanted.git or wanted.sign then
    local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, 0, -1, { details = true, type = "sign" })
    for _, extmark in pairs(extmarks) do
      local lnum = extmark[2] + 1
      signs[lnum] = signs[lnum] or {}
      local name = extmark[4].sign_hl_group or extmark[4].sign_name or ""
      local ret = {
        name = name,
        type = M.is_git_sign(name) and "git" or "sign",
        text = extmark[4].sign_text,
        texthl = extmark[4].sign_hl_group,
        priority = extmark[4].priority,
      }
      if wanted[ret.type] then
        table.insert(signs[lnum], ret)
      end
    end
  end

  -- if wanted.mark then
  --   local marks = vim.fn.getmarklist(buf)
  --   vim.list_extend(marks, vim.fn.getmarklist())
  --   for _, mark in ipairs(marks) do
  --     if mark.pos[1] == buf and mark.mark:match("[a-zA-Z]") then
  --       local lnum = mark.pos[2]
  --       signs[lnum] = signs[lnum] or {}
  --       table.insert(signs[lnum], { text = mark.mark:sub(2), texthl = "DiagnosticHint", type = "mark" })
  --     end
  --   end
  -- end

  return signs
end

function M.line_signs(buf, lnum, wanted)
  local buf_signs = sign_cache[buf]
  if not buf_signs then
    buf_signs = M.buf_signs(buf, wanted)
    sign_cache[buf] = buf_signs
  end
  local signs = buf_signs[lnum] or {}

  table.sort(signs, function(a, b)
    return (a.priority or 0) > (b.priority or 0)
  end)
  return signs
end

function M.icon(sign)
  if not sign then
    return "  "
  end
  local key = (sign.text or "") .. (sign.texthl or "")
  if icon_cache[key] then
    return icon_cache[key]
  end
  local text = vim.fn.strcharpart(sign.text or "", 0, 2)
  text = text .. string.rep(" ", 2 - vim.fn.strchars(text))
  icon_cache[key] = sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
  return icon_cache[key]
end

function M._get()
  local win = vim.g.statusline_winid
  local nu = vim.wo[win].number
  local rnu = vim.wo[win].relativenumber
  local show_signs = vim.v.virtnum == 0 and vim.wo[win].signcolumn ~= "no"
  local buf = vim.api.nvim_win_get_buf(win)
  local left_c = type(config.left) == "function" and config.left(win, buf, vim.v.lnum) or config.left
  local right_c = type(config.right) == "function" and config.right(win, buf, vim.v.lnum) or config.right

  local wanted = { sign = show_signs }
  for _, c in ipairs(left_c) do
    wanted[c] = wanted[c] ~= false
  end
  for _, c in ipairs(right_c) do
    wanted[c] = wanted[c] ~= false
  end

  local components = { "", "", "" }
  if not (show_signs or nu or rnu) then
    return ""
  end

  if (nu or rnu) and vim.v.virtnum == 0 then
    local num
    if rnu and nu and vim.v.relnum == 0 then
      num = vim.v.lnum
    elseif rnu then
      num = vim.v.relnum
    else
      num = vim.v.lnum
    end
    components[2] = "%=" .. num .. " "
  end

  if show_signs then
    local signs = M.line_signs(buf, vim.v.lnum, wanted)

    if #signs > 0 then
      local signs_by_type = {}
      for _, s in ipairs(signs) do
        signs_by_type[s.type] = signs_by_type[s.type] or s
      end

      local function find(types)
        for _, t in ipairs(types) do
          if signs_by_type[t] then
            return signs_by_type[t]
          end
        end
      end

      local left, right = find(left_c), find(right_c)
      components[1] = left and M.icon(left) or "  "
      components[3] = right and M.icon(right) or "  "
    else
      components[1] = "  "
      components[3] = "  "
    end
  end

  local ret = table.concat(components, "")
  return ret
end

function M.get()
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local key = ("%d:%d:%d:%d:%d"):format(win, buf, vim.v.lnum, vim.v.virtnum ~= 0 and 1 or 0, vim.v.relnum)
  if cache[key] then
    return cache[key]
  end
  local ok, ret = pcall(M._get)
  if ok then
    cache[key] = ret
    return ret
  end
  return ""
end

return M
