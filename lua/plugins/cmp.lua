return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      require('cmp').setup({
        sources = {
          { name = 'buffer' },
        },
      })
    end
  }
}
