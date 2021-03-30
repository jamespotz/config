require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained",

    highlight = {
        enable = true
    },

    indent = {enable = {"javascriptreact"}},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    autotag = {enable = true},
    rainbow = {enable = true},
    context_commentstring = {enable = true, config = {javascriptreact = {style_element = '{/*%s*/}'}}}
}
