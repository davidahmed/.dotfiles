local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("david.lsp.lsp-installer")
require("david.lsp.null-ls")
require("david.lsp.handlers").setup()
