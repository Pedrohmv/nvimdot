local nmap = require("ph.keymap").nmap
local vmap = require("ph.keymap").vmap

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

nmap { "K", vim.lsp.buf.hover }
nmap { "gd", vim.lsp.buf.definition }
nmap { "gr", vim.lsp.buf.references }
nmap { "<leader>rn", vim.lsp.buf.rename }
nmap { "<leader>aw", vim.lsp.buf.code_action }
vmap { "<leader>aw", vim.lsp.buf.range_code_action }

local diagnostics_active = true
vim.keymap.set('n', '<leader>td', function()
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
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
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
