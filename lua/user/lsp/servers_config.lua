local servers = { 'clangd', 'pyright', 'sumneko_lua' }

local on_attach = require('user.lsp.lsp_config').on_attach
local capabilities = require('user.lsp.lsp_config').capabilities

for _, lsp in pairs(servers) do
  local opt = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if lsp == 'clangd' then
    local clangd_opt = require('user.lsp.settings.clangd')
    opt = vim.tbl_deep_extend("force", clangd_opt, opt)
  end
  if lsp == 'pyright' then
    local pyright_opt = require('user.lsp.settings.pyright')
    opt = vim.tbl_deep_extend("force", pyright_opt, opt)
  end
  if lsp == 'sumneko_lua' then
    local lua_opt = require("user.lsp.settings.sumneko_lua")
    opt = vim.tbl_deep_extend("force", lua_opt, opt)
  end

  require('lspconfig')[lsp].setup(opt)
end
