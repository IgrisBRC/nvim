return {
    {
        "neovim/nvim-lspconfig",
        config = function ()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require'lspconfig'.clangd.setup {
                capabilities = capabilities
            }

            require'lspconfig'.gopls.setup {
                capabilities = capabilities
            }

            require'lspconfig'.lua_ls.setup {
                capabilities = capabilities
            }

            vim.diagnostic.config({virtual_text = true})
            vim.diagnostic.enable()
            vim.keymap.set('n', 'E', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-p>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>pp', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end
    }
}


