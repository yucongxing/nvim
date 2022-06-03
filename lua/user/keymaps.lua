local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', 'Q', ':q<CR>', opts)

keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)

keymap('n', '<leader>l', ':nohl<CR>', opts)

keymap('n', '<leader>c', ':cclose<CR>', opts)
