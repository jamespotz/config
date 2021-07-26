require"completion"
require"lspkind_config"
require"treesitter"
require"statusline"
require"telescope_config"
require"colorizer".setup()
require("bufferline").setup{
  options = {
    separator_style = "slant",
    diagnostic = "nvim_lsp",
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          result[1] = {text = "  " .. error, guifg = "#EC5241"}
        end

        if warning ~= 0 then
          result[2] = {text = "  " .. warning, guifg = "#EFB839"}
        end

        if hint ~= 0 then
          result[3] = {text = "  " .. hint, guifg = "#A3BA5E"}
        end

        if info ~= 0 then
          result[4] = {text = "  " .. info, guifg = "#7EA9A7"}
        end
        return result
      end
    }
  }
}

local nvim_lsp = require"lspconfig"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  buf_set_keymap("n", "<space>car", ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<space>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)


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
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative"
    }
  },
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
