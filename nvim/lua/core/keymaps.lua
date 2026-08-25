local map = vim.keymap.set

-- || General ||
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
map('i', 'fj', '<Esc>', { desc = 'Exit insert mode' })
map('n', '<leader>w', '<cmd>wa<CR>', { desc = 'Save all' })
map('n', '<space>', '/', { desc = 'Search' })
map('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' })
map('n', '<C-p>', require('core.fuzzy').open, { desc = 'Fuzzy Find interactivo' })
map('n', '<leader>g', require('core.git').open_status, { desc = 'Git Status' })

-- || Portapapeles ||
map('n', '<leader>y', '"+yy', { desc = 'Yank to system clipboard (line)' })
map('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard (selection)' })
map('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
map('v', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- || Ventanas (Splits) con integración Tmux ||
map('n', '<C-h>', function() require('core.tmux').move('h') end, { desc = 'Move left (Tmux aware)' })
map('n', '<C-l>', function() require('core.tmux').move('l') end, { desc = 'Move right (Tmux aware)' })
map('n', '<C-j>', function() require('core.tmux').move('j') end, { desc = 'Move down (Tmux aware)' })
map('n', '<C-k>', function() require('core.tmux').move('k') end, { desc = 'Move up (Tmux aware)' })
