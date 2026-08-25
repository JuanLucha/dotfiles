local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = '' -- Ratón desactivado para permitir copiar de la terminal (status bar, etc)
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 80
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.hlsearch = true
opt.colorcolumn = "120"
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.termguicolors = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.clipboard = "unnamedplus"

-- || Fuzzy Finding Nativo ||
-- Permite que `:find` busque de forma recursiva en subcarpetas
opt.path:append('**')
-- Ignorar estas carpetas al buscar o autocompletar
opt.wildignore:append({'*/node_modules/*', '*/.git/*', '*/vendor/*', '*/dist/*'})

