local ensure_installed_servers = { 'clangd', 'pyright', 'lua_ls', 'cmake' }
require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = ensure_installed_servers
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local common_opt = {capabilities = capabilities}
for _, lsp in pairs(ensure_installed_servers) do
  if lsp == 'clangd' then
    local opt = require('user.lsp.settings.clangd')
    vim.tbl_extend('force', common_opt, opt)
    lspconfig[lsp].setup(opt)
  elseif lsp == 'pyright' then
    local opt = require('user.lsp.settings.pyright')
    vim.tbl_extend('force', common_opt, opt)
    lspconfig[lsp].setup(opt)
  elseif lsp == 'lua_ls' then
    local opt = require("user.lsp.settings.sumneko_lua")
    vim.tbl_extend('force', common_opt, opt)
    lspconfig[lsp].setup(opt)
  else
    lspconfig[lsp].setup{common_opt}
  end
end
