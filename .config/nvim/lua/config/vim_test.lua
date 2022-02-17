vim.g['test#javascript#runner'] = 'jest'
vim.g['test#javascript#jest#executable'] = 'yarn test:only'
vim.g['test#strategy'] = 'floaterm'

vim.api.nvim_set_keymap('n', '<Leader>x', ':TestFile<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>xa', ':TestSuite<CR>', { silent = true })
