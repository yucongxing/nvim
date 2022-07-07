local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
  vim.notify('gitsigns not found!')
  return
end

gitsigns.setup {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 100,
    ignore_whitespace = false,
  }
}
