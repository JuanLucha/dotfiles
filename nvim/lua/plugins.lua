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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- startup and add configure plugins
packer.startup(function()
  local use = use

  -- Packer can manage itself
  use ({'wbthomason/packer.nvim', opt = false})

  -- Code highlight
  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  -- Code completion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for

  -- Fuzzy finding
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
   'nvim-lua/telescope.nvim',
   requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use 'jremmen/vim-ripgrep'

  -- Tmux integration --
  use 'christoomey/vim-tmux-navigator'

  
  -- File explorer --
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  -- Theme --
  use 'rakr/vim-one'
  use 'Rigellute/shades-of-purple.vim'

  -- Zen mode editing --
  use 'folke/zen-mode.nvim'

  -- Autopair symbols
  use 'jiangmiao/auto-pairs'

  -- Comments
  use 'tpope/vim-commentary'

  -- Formatter
  use 'sbdchd/neoformat'
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer")
  end

  end
)

-- Telescope setup
require('telescope').setup({
    defaults = {
      path_display = {"truncate"}
    }
  })

-- Treesitter config
local configs = require'nvim-treesitter.configs'
configs.setup {
  highlight = {
    enable = true,
  }
}

-- NvimTree setup
require("nvim-tree").setup()

-- Neoformat using local configuration file
vim.g.neoformat_try_node_exe = 1
