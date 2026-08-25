-- Tema "Cyberpunk 80s" nativo basado en tus colores de Tmux
local colors = {
  bg = "#0d0221",          -- Fondo ultra oscuro (espacio)
  fg = "#00ffff",          -- Cyan vibrante (texto principal)
  pink = "#ff007f",        -- Rosa neón (acento activo, cursor, strings)
  purple = "#8a2be2",      -- Morado oscuro (texto secundario, inactivo, comentarios)
  blue = "#5cc5ff",        -- Azul claro (palabras clave, separadores)
  dark_purple = "#261447", -- Morado profundo (bordes, fondos secundarios)
  yellow = "#ffff00",      -- Amarillo neón (números, especiales)
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
vim.g.colors_name = "cyberpunk"

-- =====================================
-- UI Base (Editor)
-- =====================================
hl("Normal", { bg = colors.bg, fg = colors.fg })
hl("NormalFloat", { bg = colors.dark_purple, fg = colors.fg })
hl("LineNr", { fg = colors.purple })
hl("CursorLineNr", { fg = colors.pink, bold = true })
hl("CursorLine", { bg = colors.dark_purple })
hl("ColorColumn", { bg = colors.dark_purple })
hl("Visual", { bg = colors.pink, fg = colors.bg })
hl("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
hl("IncSearch", { bg = colors.pink, fg = colors.bg, bold = true })

-- =====================================
-- Splits y Bordes
-- =====================================
hl("VertSplit", { fg = colors.pink, bg = colors.bg })
hl("WinSeparator", { fg = colors.pink, bg = colors.bg, bold = true })
hl("FloatBorder", { fg = colors.pink })

-- =====================================
-- Statusline y Tabline
-- =====================================
hl("StatusLine", { bg = colors.dark_purple, fg = colors.pink, bold = true })
hl("StatusLineNC", { bg = colors.bg, fg = colors.purple })
hl("TabLine", { bg = colors.dark_purple, fg = colors.purple })
hl("TabLineFill", { bg = colors.bg })
hl("TabLineSel", { bg = colors.bg, fg = colors.pink, bold = true })

-- =====================================
-- Sintaxis Básica (El código)
-- =====================================
hl("Comment", { fg = colors.purple, italic = true })
hl("String", { fg = colors.pink })
hl("Number", { fg = colors.yellow })
hl("Keyword", { fg = colors.blue, bold = true })
hl("Function", { fg = colors.fg, bold = true })
hl("Type", { fg = colors.blue })
hl("Constant", { fg = colors.pink })
hl("Identifier", { fg = colors.fg })
hl("Statement", { fg = colors.blue })
hl("PreProc", { fg = colors.blue })
hl("Special", { fg = colors.yellow })
hl("MatchParen", { bg = colors.pink, fg = colors.bg, bold = true })

-- =====================================
-- Diagnósticos y Otros
-- =====================================
hl("ErrorMsg", { fg = colors.bg, bg = colors.pink, bold = true })
hl("WarningMsg", { fg = colors.yellow, bold = true })
hl("Directory", { fg = colors.blue, bold = true })
hl("Title", { fg = colors.pink, bold = true })
hl("Todo", { bg = colors.yellow, fg = colors.bg, bold = true })
