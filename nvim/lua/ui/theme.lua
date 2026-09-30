-- Tema "Halloween" nativo basado en la paleta oficial para Neovim
local colors = {
  bg           = "#151317", -- Fondo Noche Oscura
  bg_alt       = "#1e1c21", -- Fondo secundario (CursorLine, Float, Pmenu)
  bg_status    = "#1a181d", -- Fondo Barra de Estado / Pestañas
  fg           = "#c0bcba", -- Gris Hueso Texto Principal
  fg_muted     = "#7f848e", -- Gris Lápida (Comentarios)
  orange       = "#e6792a", -- Naranja Calabaza (Variables, Identificadores)
  fire_orange  = "#fb6e07", -- Naranja Fuego (Selección, Búsqueda, Tab Activa)
  purple       = "#bc59d9", -- Púrpura Bruja (Keywords, Control, Storage)
  green        = "#4bc02b", -- Verde Slime (Funciones, Métodos)
  gold         = "#e5c07b", -- Dorado Cosecha (Tipos, Clases, Interfaces)
  cinnamon     = "#d19a66", -- Naranja Canela (Números, Constantes)
  bone_str     = "#bebab6", -- Gris Hueso (Strings)
  red          = "#f48771", -- Rojo Sangre (Errores)
  yellow       = "#cca700", -- Amarillo Warning
}

-- Función auxiliar para aplicar los grupos de colores
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Limpiar colores anteriores y dar nombre al tema
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "halloween"

-- =====================================
-- UI Base (Editor)
-- =====================================
hl("Normal", { bg = colors.bg, fg = colors.fg })
hl("NormalFloat", { bg = colors.bg_alt, fg = colors.fg })
hl("LineNr", { fg = colors.fg_muted })
hl("CursorLineNr", { fg = colors.orange, bold = true })
hl("CursorLine", { bg = colors.bg_alt })
hl("ColorColumn", { bg = colors.bg_alt })
hl("Visual", { bg = colors.fire_orange, fg = colors.bg })
hl("Search", { bg = colors.orange, fg = colors.bg, bold = true })
hl("IncSearch", { bg = colors.fire_orange, fg = colors.bg, bold = true })
hl("CurSearch", { bg = colors.fire_orange, fg = colors.bg, bold = true })

-- =====================================
-- Splits y Bordes
-- =====================================
hl("VertSplit", { fg = colors.orange, bg = colors.bg })
hl("WinSeparator", { fg = colors.orange, bg = colors.bg, bold = true })
hl("FloatBorder", { fg = colors.orange, bg = colors.bg_alt })

-- =====================================
-- Statusline y Tabline
-- =====================================
hl("StatusLine", { bg = colors.bg_status, fg = colors.orange, bold = true })
hl("StatusLineNC", { bg = colors.bg, fg = colors.fg_muted })
hl("TabLine", { bg = colors.bg_status, fg = colors.fg_muted })
hl("TabLineFill", { bg = colors.bg })
hl("TabLineSel", { bg = colors.fire_orange, fg = colors.bg, bold = true })
hl("Pmenu", { bg = colors.bg_alt, fg = colors.fg })
hl("PmenuSel", { bg = colors.fire_orange, fg = colors.bg, bold = true })

-- =====================================
-- Sintaxis Básica (El código)
-- =====================================
hl("Comment", { fg = colors.fg_muted, italic = true })
hl("String", { fg = colors.bone_str })
hl("Number", { fg = colors.cinnamon })
hl("Boolean", { fg = colors.cinnamon, bold = true })
hl("Float", { fg = colors.cinnamon })
hl("Keyword", { fg = colors.purple, bold = true })
hl("Function", { fg = colors.green, bold = true })
hl("Type", { fg = colors.gold, bold = true })
hl("Constant", { fg = colors.cinnamon })
hl("Identifier", { fg = colors.orange })
hl("Statement", { fg = colors.purple, bold = true })
hl("PreProc", { fg = colors.purple })
hl("Special", { fg = colors.gold })
hl("Operator", { fg = colors.cinnamon })
hl("MatchParen", { bg = colors.green, fg = colors.bg, bold = true })

-- =====================================
-- Diagnósticos y Mensajes
-- =====================================
hl("ErrorMsg", { fg = colors.bg, bg = colors.red, bold = true })
hl("WarningMsg", { fg = colors.yellow, bold = true })
hl("Directory", { fg = colors.orange, bold = true })
hl("Title", { fg = colors.orange, bold = true })
hl("Todo", { bg = colors.orange, fg = colors.bg, bold = true })
