local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
		install_path
	})
	execute 'packadd packer.nvim'
end


require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'preservim/nerdtree' -- NerdTree


	-- Completion
	use {
		'hrsh7th/nvim-cmp',
		event = "UIEnter",
		opt = false,
		requires = {
			{
				'hrsh7th/cmp-nvim-lsp',
				module = "cmp_nvim_lsp",
				opt = true
			}, {
				'hrsh7th/cmp-buffer',
				opt = true
			}, {
				'hrsh7th/cmp-path',
				opt = true
			}, {
				'hrsh7th/cmp-nvim-lua',
				opt = true
			}, {
				'saadparwaiz1/cmp_luasnip',
				opt = true
			}
		},
		config = function() require'completion'.setup() end
	}
    use {
        'L3MON4D3/LuaSnip',
        after = "nvim-cmp",
        requires = {{"rafamadriz/friendly-snippets"}},
        config = function() require'completion'.luasnip() end
    }

    use {'tpope/vim-fugitive', opt = true, event = "UIEnter"}

	if Packer_bootstrap then require('packer').sync() end
end)

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {   'pyright' }
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


require'lspconfig'.pyright.setup{}
