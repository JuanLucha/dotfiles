local lsp_status = require("lsp-status")
lsp_status.register_progress()

local lspconfig = require("lspconfig")

-- Some arbitrary servers
lspconfig.clangd.setup({
	handlers = lsp_status.extensions.clangd.setup(),
	init_options = {
		clangdFileStatus = true,
	},
	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities,
})

lspconfig.pyls_ms.setup({
	handlers = lsp_status.extensions.pyls_ms.setup(),
	settings = { python = { workspaceSymbols = { enabled = true } } },
	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities,
})

lspconfig.ghcide.setup({
	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities,
})
lspconfig.rust_analyzer.setup({
	on_attach = lsp_status.on_attach,
	capabilities = lsp_status.capabilities,
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
		on_attach(client, bufnr)
	end,
})

vim.cmd([[
" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction
]])
