local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release'
  }

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
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

  -- highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    commit = '4cccb6f'
  }

  -- gitsigns
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release'
  }
  -- dressing.nvim
  use 'stevearc/dressing.nvim'

  -- Comment
  use 'terrortylor/nvim-comment'

  --file tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
