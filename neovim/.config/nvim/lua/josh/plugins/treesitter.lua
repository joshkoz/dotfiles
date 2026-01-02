local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local ts_parsers = {
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "toml",
  "html",
  "css",
  "c",
  "cpp",
  "lua",
  "python",
  "rust",
  "tsx",
  "vimdoc",
  "vim",
  "bash",
  "c_sharp",
  "markdown",
  "markdown_inline",
  "dockerfile",
  "gitignore",
}
local nts = require("nvim-treesitter")

nts.install(ts_parsers)

autocmd("PackChanged", {
  group = augroup("joshkoz/update-nts", { clear = true }),
  callback = function()
    nts.update()
  end,
})

autocmd("FileType", {
  group = augroup("joshkoz/start-treesitter", { clear = true }),
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end,
})
