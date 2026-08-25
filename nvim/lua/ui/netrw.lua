-- Configuración del explorador nativo de Neovim (Netrw)

-- Desactivar el banner gigante superior
vim.g.netrw_banner = 0

-- Usar vista de árbol por defecto
vim.g.netrw_liststyle = 3

-- Abrir archivos en la ventana actual (pantalla completa, reemplazando a netrw)
vim.g.netrw_browse_split = 0

-- Tamaño por defecto si se abre en un split (25% de la pantalla)
vim.g.netrw_winsize = 25

-- Ocultar archivos ocultos por defecto (puedes verlos presionando 'gh' dentro de netrw)
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
