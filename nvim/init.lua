require('david')

vim.wo.relativenumber = true
vim.o.background = 'dark' -- or 'light' for light mode
vim.cmd([[colorscheme gruvbox]])
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
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------- KEY BINDINGS ---------------------------
vim.g.mapleader = ','

map('i', 'jk', '<Esc>')
map('t', 'jk', '<C-\\><C-n>')
map('i', 'uu', '<cmd>update<CR><Esc>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

--------- LSP SETUP    ---------------------------
local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup{on_attach=on_attach}
-- require'lspconfig'.vuels.setup{}
require'nvim-web-devicons'.setup {}


-------- Formatting ------------------------------
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.eslint_d.with({
          filetypes = {"vue", "javascript"}
        }),
        require("null-ls").builtins.formatting.prettier.with({
          filetypes = {"html", "json", "yaml", "markdown"},
        }),
        require("null-ls").builtins.formatting.taplo,
        require("null-ls").builtins.formatting.black.with({
          prefer_local = ".venv/bin",
        }),
        require("null-ls").builtins.diagnostics.flake8.with({
          prefer_local = ".venv/bin",
        }), 
        require("null-ls").builtins.diagnostics.eslint_d,
        require("null-ls").builtins.completion.spell,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
})

--------- Visual Enhancements --------------------
require('lualine').setup{}


--------- Telescope  --------------------
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")

--------- Autocompletion -------------------------
-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

luasnip.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			select = true
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			local luasnip = require 'luasnip'
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {"i", "s"}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			local luasnip = require 'luasnip'
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {"i", "s"})
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
