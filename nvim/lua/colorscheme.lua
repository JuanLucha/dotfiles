------------------
-- Color scheme --
------------------
vim.g.airline_theme='dracula'

vim.cmd [[
set background=dark
try
  colorscheme dracula
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
