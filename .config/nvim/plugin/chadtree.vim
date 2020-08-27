lua vim.api.nvim_set_var("chadtree_ignores", { name = {".git", ".vscode", ".vim", "node_modules"} })
lua vim.api.nvim_set_var("chadtree_settings", { keymap = { tertiary = {"<c-t>", "<middlemouse>"}} })
nnoremap <C-b> <cmd>CHADopen<cr>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "chadtree") | q | endif
