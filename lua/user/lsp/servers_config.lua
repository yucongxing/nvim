local ensure_installed_servers = { 'clangd', 'pyright', 'lua_ls', 'cmake' }
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = ensure_installed_servers
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local common_opt = { capabilities = capabilities }
for _, lsp in pairs(ensure_installed_servers) do
  if lsp == 'clangd' then
    local opt = require('user.lsp.settings.clangd')
    vim.tbl_extend('force', common_opt, opt)
    lspconfig[lsp].setup(opt)
  elseif lsp == 'lua_ls' then
    local opt = require("user.lsp.settings.sumneko_lua")
    vim.tbl_extend('force', common_opt, opt)
    lspconfig[lsp].setup(opt)
  elseif lsp == 'pyright' then
    local opt = {
      root_dir = function()
        local current_dir = vim.fn.getcwd()
        while current_dir do
          -- 检查当前目录是否包含.git目录
          if os.rename(current_dir .. '/.git', current_dir .. '/.git') then
            return current_dir -- 找到.git目录，返回该目录
          end

          -- 向上级目录查找
          current_dir = current_dir:match("^(.*)/[^/]+$")

          -- 如果已经到达根目录，停止查找
          if not current_dir or current_dir == "" then
            break
          end
        end
        return vim.fn.getcwd()
      end,
    }
    lspconfig[lsp].setup(opt)
  else
    lspconfig[lsp].setup { common_opt }
  end
end
