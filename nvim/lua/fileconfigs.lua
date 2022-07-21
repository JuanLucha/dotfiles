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

-- JS config
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.js', '*.jsx'},
  callback = function()
    vim.cmd ":Neoformat"
  end,
})

