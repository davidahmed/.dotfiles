require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree' 

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
        require("rose-pine").setup()
        vim.cmd('colorscheme rose-pine')
    end
})

	use 'tpope/vim-fugitive'
	use 'tpope/vim-surround'

	use 'neovim/nvim-lspconfig'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'

	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-web-devicons'

	-- Autocompletion --
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- Snippets --
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use "rafamadriz/friendly-snippets"

  -- vim-elxir --
  use 'elixir-editors/vim-elixir'
	-- Telescope --
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
  use {
    'nvim-telescope/telescope-media-files.nvim',
    requires = { {'nvim-telescope/telescope.nvim'} },
    config = function() 
      require('telescope').load_extension('media_files')
    end
  }
	-- Formatter --
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

  use {
  'lewis6991/gitsigns.nvim',
  }

  use('theprimeagen/harpoon')
	if Packer_bootstrap then require('packer').sync() end
end)

