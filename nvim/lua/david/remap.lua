local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
--------- Remapping Keys ---------------------------
vim.g.mapleader = ','
   
map('i', 'jk', '<Esc>')
map('t', 'jk', '<C-\\><C-n>')
map('i', 'uu', '<cmd>update<CR><Esc>')
map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

map('n', '<C-Up>', '<cmd>resize +5<CR>')
map('n', '<C-Down>', '<cmd>resize -5<CR>')
map('n', '<C-right>', '<cmd>vertical resize +5<CR>')
map('n', '<C-left>', '<cmd>vertical resize -5<CR>')

