local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require('user.lsp.lsp_config').setup()
require('user.lsp.servers_config')
