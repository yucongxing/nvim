local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
  -- color scheme
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
  },

  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',

  'lewis6991/gitsigns.nvim',

  -- Status line
  'nvim-lualine/lualine.nvim',

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'neovim/nvim-lspconfig',

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',

  "L3MON4D3/LuaSnip", --snippet engine
  'rafamadriz/friendly-snippets',

  -- autopair
  'windwp/nvim-autopairs',
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "cmake", "bash", "python" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  -- gitsigns
  'lewis6991/gitsigns.nvim',
  -- dressing.nvim
  'stevearc/dressing.nvim',

  -- Comment
  'terrortylor/nvim-comment',

  --file tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    }
  }
}

local opt = {}
require("lazy").setup(plugins, opts);
