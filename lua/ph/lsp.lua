require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "tailwindcss" }
}

-- move to rust.lua
local rt = require("rust-tools")
rt.setup()

local nmap = require("ph.keymap").nmap
local vmap = require("ph.keymap").vmap

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

nmap { "K", vim.lsp.buf.hover }
nmap { "gd", vim.lsp.buf.definition }
nmap { "gr", vim.lsp.buf.references }
nmap { "<leader>rn", vim.lsp.buf.rename }
nmap { "<leader>aw", vim.lsp.buf.code_action }

nmap { "<leader>dn", vim.diagnostic.goto_next }
nmap { "<leader>dp", vim.diagnostic.goto_prev }

local diagnostics_active = true
vim.keymap.set('n', '<leader>dd', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").tsserver.setup {
    capabilities = capabilities,
}

require("lspconfig").cssls.setup {
    capabilities = capabilities,
}

require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
}

require("lspconfig").tailwindcss.setup {
    capabilities = capabilities,
}
