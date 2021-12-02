local api = vim.api
local cmd = vim.cmd
local lsp = vim.lsp
local fn = vim.fn

require"completion"
require"lspkind_config"
require"treesitter"
require"telescope_config"
require"colorizer".setup()
require"file_explorer"
require"floaterm_config"
require"refactor"
require"trouble".setup()
require"todo-comments".setup()
require"lsp-colors".setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
require"gitsigns".setup()
require"surround".setup({mappings_style = "surround"})
require"lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "single"
  }
})

require('lualine').setup({
  options = {theme = 'onedarkpro'}
})
require("bufferline").setup{
  options = {
    separator_style = "padded-slant",
    diagnostic = "nvim_lsp",
    custom_areas = {
      right = function()
        local result = {}
        local error = lsp.diagnostic.get_count(0, [[Error]])
        local warning = lsp.diagnostic.get_count(0, [[Warning]])
        local info = lsp.diagnostic.get_count(0, [[Information]])
        local hint = lsp.diagnostic.get_count(0, [[Hint]])

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
  --Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    api.nvim_exec([[
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(lsp.protocol.make_client_capabilities())

-- Organize Import tsserver
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {api.nvim_buf_get_name(0)},
    title = ""
  }

  lsp.buf_request_sync(0, "workspace/executeCommand", params, 500)
end

-- Language Server Setups
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require'illuminate'.on_attach(client)
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
      opts.commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organize Imports"
        }
      }

      opts.init_options = {
        preferences = {
          importModuleSpecifierPreference = "relative"
        }
      }

      opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)

        api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", ":OrganizeImports<CR>", {silent = true})
        require'illuminate'.on_attach(client)
        print('Language server loaded: ', server.name)
      end

      opts.capabilities = capabilities
      opts.settings = {documentFormatting = false}
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    cmd [[ do User LspAttachBuffers ]]
end)

-- Formatting
local prettierFmt = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", api.nvim_buf_get_name(0)},
    stdin = true
  }
end

-- install npm install -g prettier-eslint-cli
local prettierEslintFmt = function()
  return {
    exe = "prettier-eslint",
    args = {"--stdin", "--stdin-filepath", api.nvim_buf_get_name(0)},
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

api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.ts,*.tsx,*.jsx,*.json,*.html,*.css,*.lua FormatWrite
  augroup END
]], true)

-- replace the default lsp diagnostic letters with prettier symbols
fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

-- nvim-lightbulb
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
