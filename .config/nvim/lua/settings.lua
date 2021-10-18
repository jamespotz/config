require"completion"
require"lspkind_config"
require"treesitter"
require"statusline"
require"telescope_config"
require"colorizer".setup()
require"nvim-tree".setup()
require"trouble".setup()
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
require"gitsigns".setup()
require"surround".setup({mappings_style = "surround"})

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


-- Snippet support
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Language Server Setups
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      print('Language server loaded: ', server.name)
    end

    if server.name == 'cssls' or server.name == 'html' then
      opts.capabilities = capabilities
    end

    if server.name == 'sqlls' then
      opts.cmd = {"sql-language-server", "up", "--method", "stdio"}
    end

    -- (optional) Customize the options passed to the server
    if server.name == "tsserver" then
      opts.init_options = {
        preferences = {
          importModuleSpecifierPreference = "relative"
        }
      }

      opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
        print('Language server loaded: ', server.name)
      end

      opts.capabilities = capabilities
      opts.settings = {documentFormatting = false}
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Formatting
local prettierFmt = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

-- install npm install -g prettier-eslint-cli
local prettierEslintFmt = function()
  return {
    exe = "prettier-eslint",
    args = {"--stdin", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require"formatter".setup({
  logging = false,
  filetype = {
    typescriptreact = {prettierEslintFmt},
    typescript = {prettierEslintFmt},
    javascript = {prettierEslintFmt},
    javascriptreact = {prettierEslintFmt},
    json = {prettierFmt},
    html = {prettierFmt},
    css = {prettierFmt}
  }
})

vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx,*.json,*.html,*.css,*.lua FormatWrite
  augroup END
]], true)

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
