local nmap = require("ph.keymap").nmap
local vmap = require("ph.keymap").vmap

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local clear_au = vim.api.nvim_clear_autocmds

-- Autoformat on save
local augroup = ag("LspFormatting", { clear = false })
au("BufWritePre", {
  clear_au({ group = augroup, buffer = bufnr }),
  group = augroup,
  buffer = bufnr,
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx,*.js,*.jsx,*.rs,*.css,*.html,*.json,*.scss,*.xml",
  command = "Prettier",
  desc = "Format on save"
})

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
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'pylsp' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").ts_ls.setup {
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

require("lspconfig").pylsp.setup {
  capabilities = capabilities,
}

require("lspconfig").rust_analyzer.setup {
  capabilities = capabilities,
}
