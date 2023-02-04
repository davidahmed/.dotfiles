function ColorMyPencils(color)
	color = color or "neon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(1, "InsertMode", { bg = "none" })
	vim.api.nvim_set_hl(40, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
