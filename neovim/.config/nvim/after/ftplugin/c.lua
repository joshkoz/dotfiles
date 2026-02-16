vim.opt.makeprg = "cmake --build --preset Debug --clean-first"
vim.opt.errorformat = table.concat({
  [[%f:%l:%c: %t%*[^:]: %m]],
  [[%f:%l:%c: %m]],
  [[%-G%f:%sIn function %.%#]],
  [[%-GIn file included from %.%#]],
  [[%-G%\\s%#%l%\\s%#|%.%#]],
  [[%-G%\\s%#|%.%#]],
  [[%-G%\\s%#^%.%#]],
  [[%-G[%\\s%#%\\d%\\+%%] %.%#]],
  [[%-Gmake%.%#]],
  [[%-G%\\s%#]],
}, ",")
