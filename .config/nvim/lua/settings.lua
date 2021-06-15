require"completion"
require"lspkind_config"
require"treesitter"
require"statusline"
require"telescope_config"
require"nvim-treesitter.configs".setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  }
}
require"colorizer".setup()

local nvim_lsp = require"lspconfig"

-- Common keymaps
vim.cmd('nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>')
vim.cmd('nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> ca :Lspsaga code_action<CR>')
vim.cmd('vnoremap <silent> <leader>ca :<C-U>Lspsaga range_code_action<CR>')
vim.cmd('nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>')
vim.cmd('nnoremap <silent> gR :Lspsaga rename<CR>')
vim.cmd('nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>')
vim.cmd('nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <silent> <leader>f :lua vim.lsp.buf.formatting()<CR>')
vim.cmd('nnoremap <silent> <leader>fr :lua vim.lsp.buf.range_formatting()<CR>')

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
-- npm i -g prettier eslint_d
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
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- TypeScript
-- npm install -g typescript typescript-language-server
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
    print('Tsserver loaded!')
  end,
  capabilities = capabilities,
  settings = {documentFormatting = false}
}

-- Docker
-- npm install -g dockerfile-language-server-nodejs
nvim_lsp.dockerls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('Docker language server loaded!')
  end
}

-- SQL/MySQL
-- npm i -g sql-language-server
nvim_lsp.sqlls.setup {
  cmd = {"sql-language-server", "up", "--method", "stdio"},
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('Sql language server loaded!')
  end
}

-- HTML
-- npm install -g vscode-html-languageserver-bin
nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('HTML language server loaded!')
  end
}

-- CSS
-- npm install -g vscode-css-languageserver-bin
nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('CSS language server loaded!')
  end
}

-- EFM (General purpose Language Server that can use specified error message format generated from specified command)
-- go get github.com/mattn/efm-langserver
nvim_lsp.efm.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    print('EFM loaded!')
  end,
  init_options = {documentFormatting = true, codeAction = false},
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

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
