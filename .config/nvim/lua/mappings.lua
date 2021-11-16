local map = function(mode, lhs, rhs, options)
  local opts = { noremap = true }
  for k,v in pairs(options or {}) do opts[k] = v end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

--Remap space as leader key
map('', '<Space>', '<Nop>', {silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true })

map('v', 'J', ":m '>+1<CR>gv=gv", {silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", {silent = true })

-- Y yank until the end of line  (note: this is now a default on master)
map('n', 'Y', 'y$')

-- Common Keymaps
map('i', '<C-c>', '<esc>')
map('n', '<Leader>u', ':UndoTreeShow')
map('n', 'R', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc")
map('n', '<Leader>,', ':nohlsearch<CR>')
map('n', '$', '$1')

-- Center when navigating search results
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Easy select all of file
map("n", "<Leader>sa", "ggVG<c-$>")

-- Tab to switch buffers in Normal mode
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- HOP config
require("hop").setup()
map("n", "f", "<cmd>lua require'hop'.hint_words()<cr>")
map("n", "F", "<cmd>lua require'hop'.hint_lines()<cr>")
map("v", "f", "<cmd>lua require'hop'.hint_words()<cr>")
map("v", "F", "<cmd>lua require'hop'.hint_lines()<cr>")

-- Move current line with Alt+j/k
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
