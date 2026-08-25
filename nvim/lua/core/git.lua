local M = {}

function M.open_status()
  -- 1. Ejecutar git status
  local obj = vim.system({'git', 'status', '--porcelain'}, { text = true }):wait()
  if obj.code ~= 0 then
    print("No estás en un repositorio Git.")
    return
  end

  local lines = vim.split(obj.stdout, '\n', { trimempty = true })
  if #lines == 0 then
    print("El árbol de trabajo está limpio.")
    return
  end

  -- Transformar la salida cruda de git a algo más amigable
  for i, line in ipairs(lines) do
    if line:sub(1, 2) == "??" then
      lines[i] = " U" .. line:sub(3)
    end
  end

  -- 2. Crear un buffer temporal (scratch buffer)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Evitar que se pueda escribir en el buffer accidentalmente
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = 'gitstatus'

  -- 3. Abrir en una pestaña nueva ("una página")
  vim.cmd('tabnew')
  vim.api.nvim_set_current_buf(buf)

  -- 4. Mapear Enter (<CR>) para abrir el diff
  vim.keymap.set('n', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    if line == "" then return end
    
    -- El formato porcelain de git status tiene 3 caracteres al inicio (ej: " M archivo.txt")
    local file = string.sub(line, 4)
    
    -- Cerrar la pestaña de estado
    vim.cmd('tabclose')
    
    -- Abrir el archivo de trabajo
    vim.cmd('edit ' .. file)
    local worktree_win = vim.api.nvim_get_current_win()
    local ft = vim.bo.filetype
    
    -- Crear split vertical a la izquierda para la versión HEAD
    vim.cmd('leftabove vsplit')
    local head_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(head_buf)
    
    -- Obtener el contenido de HEAD
    local head_obj = vim.system({'git', 'show', 'HEAD:' .. file}, { text = true }):wait()
    if head_obj.code == 0 then
        local head_lines = vim.split(head_obj.stdout, '\n')
        vim.api.nvim_buf_set_lines(head_buf, 0, -1, false, head_lines)
    else
        vim.api.nvim_buf_set_lines(head_buf, 0, -1, false, {"Archivo nuevo o no presente en HEAD"})
    end
    
    -- Configurar el buffer HEAD como temporal
    vim.bo[head_buf].modifiable = false
    vim.bo[head_buf].bufhidden = 'wipe'
    vim.bo[head_buf].filetype = ft
    
    -- Activar modo diff en ambas ventanas
    vim.cmd('diffthis')
    vim.api.nvim_set_current_win(worktree_win)
    vim.cmd('diffthis')
    
  end, { buffer = buf, desc = 'Abrir diff del archivo' })
  
  -- Extra: mapear 'q' para cerrar la página fácilmente
  vim.keymap.set('n', 'q', '<cmd>tabclose<CR>', { buffer = buf, desc = 'Cerrar git status' })
end

return M
