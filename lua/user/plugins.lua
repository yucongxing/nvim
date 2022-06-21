local fn = vim.fn

-- Bootstrap for packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print "Install packer close and reopen Neovim"
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup pack_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.init {
  display = {

  }
}

return packer.startup(function(use)

  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- LSP
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'

  -- color scheme
  use 'overcache/NeoSolarized'
  use 'navarasu/onedark.nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  use "L3MON4D3/LuaSnip" --snippet engine
  use 'rafamadriz/friendly-snippets'

  -- autopair
  use 'windwp/nvim-autopairs'

  -- neovim-cmake
  use 'Shatur/neovim-cmake'
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- dressing.nvim
  use 'stevearc/dressing.nvim'

  -- Comment
  use 'terrortylor/nvim-comment'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end
)
