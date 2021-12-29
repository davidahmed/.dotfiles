require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree' 

	use 'ellisonleao/gruvbox.nvim'
	use 'rktjmp/lush.nvim'

	use 'tpope/vim-fugitive'
	use 'tpope/vim-surround'

	use 'neovim/nvim-lspconfig'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'

	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-web-devicons'

	if Packer_bootstrap then require('packer').sync() end
end)

vim.wo.relativenumber = true
vim.o.background = 'dark' -- or 'light' for light mode
vim.cmd([[colorscheme gruvbox]])
vim.o.termguicolors = true


local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------- KEY BINDINGS ---------------------------
vim.g.mapleader = ','

map('i', 'jk', '<Esc>')
map('i', 'uu', '<cmd>update<CR><Esc>')
map('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>')


--------- LSP SETUP    ---------------------------
local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup{}

require'nvim-web-devicons'.setup {}
require('lualine').setup{}
