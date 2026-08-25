local M = {}

function M.move(direction)
  -- Guardamos la ventana actual
  local current_win = vim.api.nvim_get_current_win()
  
  -- Intentamos movernos dentro de Neovim
  vim.cmd('wincmd ' .. direction)
  
  -- Si la ventana sigue siendo la misma, significa que estamos en el borde de Neovim.
  -- Si la variable de entorno TMUX existe, le decimos a Tmux que cambie de panel.
  if current_win == vim.api.nvim_get_current_win() and vim.env.TMUX ~= nil then
    local tmux_dirs = { h = '-L', j = '-D', k = '-U', l = '-R' }
    vim.fn.system('tmux select-pane ' .. tmux_dirs[direction])
  end
end

return M
