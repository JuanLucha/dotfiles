local M = {}
local ns = vim.api.nvim_create_namespace("fuzzy")

function M.open()
  -- 1. Obtener todos los archivos usando git o find
  local all_files = {}
  local obj = vim.system({'git', 'ls-files'}, { text = true }):wait()
  if obj.code == 0 then
    all_files = vim.split(obj.stdout, '\n', { trimempty = true })
  else
    local obj2 = vim.system({'find', '.', '-type', 'f', '-not', '-path', '*/.git/*'}, { text = true }):wait()
    for _, f in ipairs(vim.split(obj2.stdout, '\n', { trimempty = true })) do
      table.insert(all_files, f:gsub("^%./", "")) -- limpiar ./ del inicio
    end
  end

  -- 2. Crear una pestaña y un buffer temporal
  vim.cmd('tabnew')
  local buf = vim.api.nvim_get_current_buf()
  
  -- Limpiar la UI de esta ventana (pero manteniendo los números por petición popular)
  vim.opt_local.number = true
  vim.opt_local.relativenumber = true
  vim.opt_local.signcolumn = 'no'
  vim.opt_local.cursorline = false
  
  -- Estado interno del buscador
  local query = ""
  local filtered = all_files
  local cursor_idx = 1
  
  -- 3. Función de renderizado reactiva
  local function render()
    vim.bo[buf].modifiable = true
    
    -- A) Filtrado Fuzzy
    if query == "" then
      filtered = all_files
    else
      filtered = {}
      for _, f in ipairs(all_files) do
        local match = true
        local last_idx = 0
        local query_lower = query:lower()
        for i = 1, #query_lower do
          local char = query_lower:sub(i, i)
          -- Busca el caracter en la ruta, respetando el orden
          local pos = f:lower():find(char, last_idx + 1, true)
          if not pos then
            match = false
            break
          end
          last_idx = pos
        end
        if match then table.insert(filtered, f) end
        if #filtered > 150 then break end -- Límite para no congelar el editor
      end
    end
    
    -- B) Limitar cursor
    if cursor_idx > #filtered then cursor_idx = math.max(1, #filtered) end
    if cursor_idx < 1 then cursor_idx = 1 end
    
    -- C) Dibujar pantalla
    local lines = { " 🔎 " .. query .. "█", " ─────────────────────────────────────" }
    for i = 1, math.min(40, #filtered) do
      table.insert(lines, "  " .. filtered[i])
    end
    
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- D) Resaltar la línea seleccionada (la línea 1 es el prompt, la 2 el separador)
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    if #filtered > 0 then
      vim.api.nvim_buf_add_highlight(buf, ns, "Search", cursor_idx + 1, 0, -1)
    end
    
    vim.bo[buf].modifiable = false
  end
  
  render()
  
  -- 4. Capturar teclas (El buffer se queda en modo normal, pero simula escritura)
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-. /"
  for i = 1, #chars do
    local c = chars:sub(i,i)
    vim.keymap.set('n', c, function()
      query = query .. c
      render()
    end, { buffer = buf, nowait = true })
  end
  
  -- Borrar
  vim.keymap.set('n', '<BS>', function()
    if #query > 0 then
      query = query:sub(1, -2)
      render()
    end
  end, { buffer = buf, nowait = true })
  
  -- Navegación (C-j, C-k)
  vim.keymap.set('n', '<C-j>', function()
    cursor_idx = cursor_idx + 1
    render()
  end, { buffer = buf, nowait = true })
  
  vim.keymap.set('n', '<C-k>', function()
    cursor_idx = cursor_idx - 1
    render()
  end, { buffer = buf, nowait = true })
  
  -- Abrir archivo
  vim.keymap.set('n', '<CR>', function()
    if #filtered > 0 then
      local file = filtered[cursor_idx]
      vim.cmd('tabclose')
      vim.cmd('edit ' .. file)
    end
  end, { buffer = buf, nowait = true })
  
  -- Salir
  vim.keymap.set('n', '<Esc>', '<cmd>tabclose<CR>', { buffer = buf, nowait = true })
  vim.keymap.set('n', '<C-c>', '<cmd>tabclose<CR>', { buffer = buf, nowait = true })
end

return M
