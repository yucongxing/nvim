# Dotfiles For Neovim

## The directories tree
.

├── init.lua

├── init.vim.backup

├── lua

│   └── user

│       ├── basic_config.lua

│       ├── colorscheme.lua

│       ├── config

│       │   ├── autopairs.lua

│       │   ├── cmake.lua

│       │   ├── cmp.lua

│       │   ├── comment.lua

│       │   ├── init.lua

│       │   ├── lualine.lua

│       │   └── treesitter.lua

│       ├── keymaps.lua

│       ├── lsp

│       │   ├── init.lua

│       │   ├── lsp_config.lua

│       │   ├── servers_config.lua

│       │   └── settings

│       │       ├── clangd.lua

│       │       ├── pyright.lua

│       │       └── sumneko_lua.lua

│       └── plugins.lua

└── README.md

## File introduction
|File|Usage|
|----|----|
|init.lua|init file|
|lua/user|config files|
|lua/user/basic_config.lua|basic config like line number, cursorline and autocmd|
|lua/user/keymaps.lua|custom keymaps|
|lua/user/colorscheme.lua|colorscheme setting|
|lua/user/plugins.lua|plugin manager by packer.nvim|
|lua/user/lsp|lsp config by nvim-lspconfig and nvim-cmp|
|lua/user/config|config for single plugin|
