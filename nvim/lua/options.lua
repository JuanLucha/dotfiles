-------------------
-- Basic options --
-------------------
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.cmdheight = 2
vim.opt.completeopt='menuone,noinsert,noselect'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.conceallevel = 0
vim.opt.ignorecase = true
vim.opt.showtabline = 2
vim.opt.updatetime = 300
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.cmd ":hi CursorLine gui=underline cterm=underline ctermbg=NONE guibg=NONE"

-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2
-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1

