local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  vim.notify('nvim-lsp-installer not found!')
  return
end

require('nvim-lsp-installer').setup {}

local servers = { 'clangd', 'pyright', 'sumneko_lua', 'cmake', 'bashls' }

local on_attach = require('user.lsp.lsp_config').on_attach
local capabilities = require('user.lsp.lsp_config').capabilities

for _, name in pairs(servers) do
  local is_found, server = lsp_installer.get_server(name)
  if not is_found then
    print('Installing ' .. name)
    lsp_installer.install(name)
  end

  local opt = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server.name == 'clangd' then
    local clangd_opt = require('user.lsp.settings.clangd')
    opt = vim.tbl_deep_extend("force", clangd_opt, opt)
  end
  if server.name == 'pyright' then
    local pyright_opt = require('user.lsp.settings.pyright')
    opt = vim.tbl_deep_extend("force", pyright_opt, opt)
  end
  if server.name == 'sumneko_lua' then
    local lua_opt = require("user.lsp.settings.sumneko_lua")
    opt = vim.tbl_deep_extend("force", lua_opt, opt)
  end

  require('lspconfig')[server.name].setup(opt)
end
