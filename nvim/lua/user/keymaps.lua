local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Search with space
keymap("n", "<Space>", "/", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Open telescope
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)

-- Paste without yanking the old text
keymap("v", "p", '"_dP', opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<S-j>", "<C-d>", opts)
keymap("n", "<S-k>", "<C-u>", opts)

-- Copy the whole line as god demands
keymap("n", "Y", "yy", opts)

-- Git
keymap("n", "ch", ":diffget //2<CR>", opts)
keymap("n", "cl", ":diffget //3<CR>", opts)

-- Nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Press jk fast to enter
keymap("i", "fj", "<ESC>", opts)

-- Save and quit
keymap("n", "<leader>w", ":wa<CR>", opts)
keymap("n", "<leader>Q", ":wqa<CR>", opts)

-- Search and find
keymap("n", "<leader>f", ":Telescope live_grep<CR>", opts)
