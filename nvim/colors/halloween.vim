" ==============================================================================
" Halloween Neovim/Vim Colorscheme
" Basado en el tema Halloween para VS Code (https://github.com/berensn/halloween)
" ==============================================================================

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "halloween"
set background=dark

" --- Paleta de Colores ---
" Noche Oscura (Fondos)  : #151317, #1a181d, #1e1c21
" Calabaza / Fuego       : #e6792a, #fb6e07, #be5406
" Púrpura Bruja          : #bc59d9
" Slime / Veneno         : #4bc02b
" Dorado Cosecha / Ámbar : #e5c07b, #d19a66, #bc8b57
" Gris Hueso             : #c0bcba, #d4d4d4, #bebab6
" Gris Lápida            : #7f848e
" Rojo Sangre / Error    : #f48771, #f44747

" ==============================================================================
" UI del Editor (Grupos Highlight Base)
" ==============================================================================
hi Normal           guifg=#c0bcba guibg=#151317 ctermfg=250 ctermbg=233
hi Terminal         guifg=#c0bcba guibg=#151317
hi NormalFloat      guifg=#c0bcba guibg=#1e1c21
hi FloatBorder      guifg=#e6792a guibg=#1e1c21
hi CursorLine       guibg=#1e1c21 gui=NONE
hi CursorColumn     guibg=#1e1c21
hi ColorColumn      guibg=#1e1c21
hi LineNr           guifg=#7f848e guibg=#151317 ctermfg=244
hi CursorLineNr     guifg=#e6792a guibg=#1e1c21 gui=bold ctermfg=208
hi Folded           guifg=#7f848e guibg=#1a181d
hi FoldColumn       guifg=#7f848e guibg=#151317
hi SignColumn       guifg=#7f848e guibg=#151317
hi VertSplit        guifg=#e6792a guibg=#151317 gui=NONE
hi WinSeparator     guifg=#e6792a guibg=#151317 gui=bold

" --- Menú Desplegable (Pmenu) ---
hi Pmenu            guifg=#c0bcba guibg=#1e1c21
hi PmenuSel         guifg=#151317 guibg=#fb6e07 gui=bold
hi PmenuSbar        guibg=#1a181d
hi PmenuThumb       guibg=#e6792a

" --- Barra de Estado y Pestañas ---
hi StatusLine       guifg=#e6792a guibg=#1a181d gui=bold
hi StatusLineNC     guifg=#7f848e guibg=#151317 gui=NONE
hi TabLine          guifg=#7f848e guibg=#1a181d gui=NONE
hi TabLineSel       guifg=#151317 guibg=#fb6e07 gui=bold
hi TabLineFill      guifg=#151317 guibg=#151317

" --- Selección y Búsqueda ---
hi Visual           guifg=#151317 guibg=#fb6e07
hi VisualNOS        guifg=#151317 guibg=#fb6e07
hi Search           guifg=#151317 guibg=#e6792a gui=bold
hi IncSearch        guifg=#151317 guibg=#fb6e07 gui=bold
hi CurSearch        guifg=#151317 guibg=#fb6e07 gui=bold
hi MatchParen       guifg=#151317 guibg=#4bc02b gui=bold

" --- Mensajes de Diagnóstico y Errores ---
hi ErrorMsg         guifg=#151317 guibg=#f48771 gui=bold
hi WarningMsg       guifg=#cca700 guibg=#151317 gui=bold
hi MoreMsg          guifg=#4bc02b gui=bold
hi Question         guifg=#4bc02b gui=bold
hi Title            guifg=#e6792a gui=bold

" --- Diffs y Git ---
hi DiffAdd          guifg=#e4e4e4 guibg=#27403b
hi DiffChange       guifg=#e4e4e4 guibg=#0c7d9d
hi DiffDelete       guifg=#e4e4e4 guibg=#94151b
hi DiffText         guifg=#151317 guibg=#e6792a gui=bold

" ==============================================================================
" Resaltado de Sintaxis
" ==============================================================================

" --- Comentarios (Gris Lápida) ---
hi Comment          guifg=#7f848e gui=italic ctermfg=244

" --- Constantes, Cadenas y Números ---
hi Constant         guifg=#d19a66 ctermfg=173
hi String           guifg=#bebab6 ctermfg=250
hi Character        guifg=#bebab6
hi Number           guifg=#d19a66 ctermfg=173
hi Boolean          guifg=#d19a66 gui=bold
hi Float            guifg=#d19a66

" --- Variables e Identificadores (Naranja Calabaza) ---
hi Identifier       guifg=#e6792a ctermfg=208
hi Function         guifg=#4bc02b gui=bold ctermfg=76

" --- Sentencias, Palabras Clave y Control (Púrpura Bruja) ---
hi Statement        guifg=#bc59d9 gui=bold ctermfg=134
hi Conditional      guifg=#bc59d9 gui=bold
hi Repeat           guifg=#bc59d9 gui=bold
hi Label            guifg=#bc59d9
hi Operator         guifg=#bc8b57
hi Keyword          guifg=#bc59d9 gui=bold ctermfg=134
hi Exception        guifg=#bc59d9 gui=bold

" --- Preprocesador y Macros ---
hi PreProc          guifg=#bc59d9
hi Include          guifg=#4bc02b gui=bold
hi Define           guifg=#bc59d9
hi Macro            guifg=#bc59d9
hi PreCondit        guifg=#bc59d9

" --- Tipos y Clases (Dorado Cosecha) ---
hi Type             guifg=#e5c07b gui=bold ctermfg=179
hi StorageClass     guifg=#bc59d9 gui=bold
hi Structure        guifg=#e5c07b gui=bold
hi Typedef          guifg=#e5c07b gui=bold

" --- Elementos Especiales y Markdown ---
hi Special          guifg=#e5c07b
hi SpecialChar      guifg=#e6792a
hi Tag              guifg=#e6792a gui=bold
hi Delimiter        guifg=#d4d4d4
hi SpecialComment   guifg=#7f848e gui=italic
hi Debug            guifg=#bc59d9

hi Underlined       guifg=#bc59d9 gui=underline
hi Ignore           guifg=#7f848e
hi Error            guifg=#ffffff guibg=#f44747 gui=bold
hi Todo             guifg=#151317 guibg=#e6792a gui=bold
