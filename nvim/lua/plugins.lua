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

vim.g.did_load_filetypes = 1

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'neovim/nvim-lspconfig',
        event = 'VimEnter',
        config = function() require'lsp'.setup() end
    }
    use {
        'williamboman/nvim-lsp-installer',
        opt = true,
        module = 'nvim-lsp-installer',
        run = function()
            local lsp_installer = require 'nvim-lsp-installer'
            -- Ensure installed
            local servers = {
                "sumneko_lua", "tsserver", "tailwindcss", "pyright", "clangd", "cssls"
            }

            for _, name in pairs(servers) do
                local server_is_found, server = lsp_installer.get_server(name)
                if (server_is_found and not server:is_installed()) then
                    print("Installing " .. name)
                    server:install()
                end
            end
        end
    }

    if Packer_bootstrap then require('packer').sync() end
end)
