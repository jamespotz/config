local g = vim.g

-- settings
g.nvim_tree_gitignore = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_refresh_wait = 300
g.nvim_tree_highlight_opened_files = 1

g.nvim_tree_special_files = {}
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★',
    deleted = '',
    ignored = '◌',
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },

  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

require('nvim-tree').setup(
  {
    auto_close = true,
    diagnostics = {
      enable = true,
    },
    update_focused_file = {
      enable = true,
      ignore_list = {},
    },
  }
)

local vim = vim.api
vim.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFiles<CR>', { noremap = true, silent = true })
