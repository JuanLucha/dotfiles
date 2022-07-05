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
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.cmd ":hi CursorLine gui=underline cterm=underline ctermbg=NONE guibg=NONE"

-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2
-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1


--------------
-- Mappings --
--------------
vim.g.mapleader = ','

-- Function to make mapping less verbose
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- Using key_mapper for the mappings
key_mapper('i', 'fj', '<ESC>')
key_mapper('n', 'Y', 'yy')
key_mapper('n', ' ', '/')
key_mapper('n', '<Leader>w', ':w<CR>')

-- Movement
key_mapper('n', 'J', '<C-d>')
key_mapper('n', 'K', '<C-u>')

-- LSP Mappings
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- Fuzzy finding
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- NvimTree
key_mapper('n', '<leader>e', ':NvimTreeFindFile<CR>')
key_mapper('n', '<leader>eq', ':NvimTreeClose<CR>')

-- Copy path to clipboard
key_mapper('n', '<leader>x', ':let @"=expand("%:p")')


-------------
-- Plugins --
-------------

-- We make sure Packer is installed
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

-- startup and add configure plugins
packer.startup(function()
  local use = use

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Code highlight
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  -- Code completion
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'williamboman/nvim-lsp-installer'

  -- Fuzzy finding
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'

  -- Tmux integration --
  use 'christoomey/vim-tmux-navigator'
  
  -- File explorer --
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  end
)

-- Telescope setup
require('telescope').setup()

-- Treesitter config
local configs = require'nvim-treesitter.configs'
configs.setup {
  highlight = {
    enable = true,
  }
}

-- LSP config
local lspconfig = require'lspconfig'
local completion = require'completion'
local function custom_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
end
local default_config = {
  on_attach = custom_on_attach,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

-- NvimTree setup
require("nvim-tree").setup()


----------------------
-- Filetype configs --
----------------------

-- Markdown configure
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.md'},
  callback = function()
    vim.api.nvim_win_set_option(0, "wrap", true)
    vim.api.nvim_win_set_option(0, "linebreak", true)
  end,
})

