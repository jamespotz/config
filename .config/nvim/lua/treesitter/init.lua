require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained",

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },

    indent = {
      enable = true,
      disable = { 'yaml' }
    },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    autotag = {enable = true},
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
    context_commentstring = {enable = true, config = {javascriptreact = {style_element = '{/*%s*/}'}}},
}
