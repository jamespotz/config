require"completion"
require"lspkind_config"
require"treesitter"
require"statusline"
require"telescope_config"

local nvim_lsp = require"lspconfig"

-- Common keymaps
vim.cmd('nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>')
vim.cmd('nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> ca :Lspsaga code_action<CR>')
vim.cmd('nnoremap <silent> K :Lspsaga hover_doc<CR>')
vim.cmd('nnoremap <silent> gR :Lspsaga rename<CR>')
vim.cmd('nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>')
vim.cmd('nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <space>f :lua vim.lsp.buf.formatting()<CR>')
vim.cmd('nnoremap <space>fr :lua vim.lsp.buf.range_formatting()<CR>')

local on_attach = function(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- javascript formatters and linter
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

-- Snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
    print('Tsserver loaded!')
  end,
  capabilities = capabilities,
  settings = {documentFormatting = false}
}

nvim_lsp.dockerls.setup {}

nvim_lsp.efm.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('EFM loaded!')
  end,
  init_options = {documentFormatting = true},
  filetypes = {"javascriptreact", "javascript", "typescript", "typescriptreact", "html", "css", "json", "yaml"},
  settings = {
      rootMarkers = {".git/"},
      languages = {
          javascriptreact = {prettier, eslint},
          javascript = {prettier, eslint},
          typescriptreact = {prettier, eslint},
          typescript = {prettier, eslint},
          html = {prettier},
          css = {prettier},
          json = {prettier},
          yaml = {prettier},
      }
  }
}

vim.api.nvim_exec([[
  autocmd BufWritePre *.js,*.json lua vim.lsp.buf.formatting_sync(nil, 1000)
]], false)
