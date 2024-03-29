local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("david.lsp.handlers").on_attach,
		capabilities = require("david.lsp.handlers").capabilities,
	}

	server:setup(opts)
end)
