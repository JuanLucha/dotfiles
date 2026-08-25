local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["R"] = "REPLACE",
  ["c"] = "COMMAND",
  ["r"] = "PROMPT",
  ["rm"] = "MORE",
  ["t"] = "TERMINAL",
}

-- Creamos una función global que Neovim pueda llamar desde C
_G.StatuslineMode = function()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format("[%s]", modes[current_mode] or current_mode)
end

-- Construcción de la statusline usando las variables nativas (%f = archivo, %m = modificado, %= = alinear a la derecha, %l:%c = línea y columna)
vim.opt.statusline = " %{%v:lua.StatuslineMode()%}  %f %m %= %l:%c "
