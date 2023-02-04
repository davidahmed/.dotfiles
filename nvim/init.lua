require("david")

vim.wo.relativenumber = true
vim.o.background = "dark" -- or 'light' for light mode
vim.o.termguicolors = true
vim.o.hlsearch = false
vim.o.hidden = true
vim.o.incsearch = true
vim.o.swapfile = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------- Visual Enhancements --------------------
require("lualine").setup({})
require("nvim-web-devicons").setup({})

