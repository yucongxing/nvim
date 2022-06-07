local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', 'Q', ':q<CR>', opts)

keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)

keymap('n', '<leader>l', ':nohl<CR>', opts)

keymap('n', '<leader>c', ':cclose<CR>', opts)

_G.F5Compile = function()
  vim.cmd(':w')
  vim.opt.splitbelow = true
  vim.cmd(':sp')
  vim.cmd(':res 10')
  if vim.bo.filetype == 'cpp' then
    vim.cmd(':term g++ -std=c++17 -Wall % -o %<.out && %<.out')
  elseif vim.bo.filetype == 'c' then
    vim.cmd(':term gcc -Wall % -o %<.out && %<.out')
  elseif vim.bo.filetype == 'py' then
    vim.cmd(':term python %')
  elseif vim.bo.filetype == 'sh' then
    vim.cmd(':term bash %')
  end
end

keymap('n', '<F5>', '<cmd>lua F5Compile()<CR>', opts)
keymap('n', '<leader>rc', ':vsplit $MYVIMRC<CR>', opts)
