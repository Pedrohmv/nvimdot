require("ph.plugins")
require("ph.set")
require("ph.telescope")
require("ph.snippets")
require("ph.flutter")
require("ph.lsp")
require("ph.lsp")
require("lualine").setup {
  sections = {
    lualine_c = { {
      'filename',
      path = 1,
    } },
  }
}
require("ph.tree")
require("ph.lazygit")
require('dressing').setup({
  input = { enabled = false, }
})
