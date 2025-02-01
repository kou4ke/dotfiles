-- config/cmp.lua


-- 必要なモジュールをロード
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({

    snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {

        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),

        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()

            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()

            end
        end, { 'i', 's' }),
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 'c' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },

        { name = 'luasnip' },

    }, {
        { name = 'buffer' },
    })
})


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {

    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    },
    mapping = cmp.mapping.preset.cmdline({
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enterキーで選択を確定
    }),
})


-- Use cmdline & path source for `:` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local schemastore = require('schemastore')

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig.pyright.setup {
    capabilities = capabilities
}
lspconfig.intelephense.setup {
    capabilities = capabilities
}
lspconfig.volar.setup {
    cmd = { "vls" },
    capabilities = capabilities
}
lspconfig.bashls.setup {
    capabilities = capabilities
}
lspconfig.terraformls.setup {
    capabilities = capabilities
}
-- Docker (Dockerfile Language Server)

lspconfig.dockerls.setup {
    capabilities = capabilities

}


-- YAML (YAML Language Server)
lspconfig.yamlls.setup {
    capabilities = capabilities
}


-- JSON (JSON Language Server)

lspconfig.jsonls.setup {
    cmd = { "vscode-json-languageserver", "--stdio" },
    capabilities = capabilities,
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        },
    },
}

-- HTML (HTML Language Server)
lspconfig.html.setup {
    capabilities = capabilities
}

-- CSS (CSS Language Server)

lspconfig.cssls.setup {
    capabilities = capabilities
}

-- SQL (SQL Language Server)
lspconfig.sqls.setup {

    capabilities = capabilities
}
