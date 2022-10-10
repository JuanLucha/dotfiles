------------------
-- Color scheme --
------------------
vim.g.airline_theme='shades_of_purple'

vim.cmd [[
set background=dark
try
  colorscheme shades_of_purple
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
