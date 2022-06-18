local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end
local current_filetype = vim.bo.filetype
if current_filetype == 'cpp' or current_filetype == 'py' or current_filetype == 'lua' then
  vim.cmd([[
    augroup _format
      autocmd!
      autocmd BufWritePre * :Format
      augroup end
  ]])
end

require('user.lsp.lsp_config').setup()
require('user.lsp.servers_config')
