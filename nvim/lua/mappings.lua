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
key_mapper('n', '<Leader>w', ':wa<CR>')

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
