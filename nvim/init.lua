-- Configurar el líder SIEMPRE antes de cargar cualquier otra cosa
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Cargar configuración modular
require('core.options')
require('core.keymaps')
require('ui.netrw')
require('ui.statusline')
require('ui.theme')
