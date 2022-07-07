------------------
-- Color scheme --
------------------
vim.g.airline_theme='one'

vim.cmd [[
set background=dark
try
  colorscheme one
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
