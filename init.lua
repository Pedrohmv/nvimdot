require("ph.plugins")
require("ph.set")
require("ph.telescope")
require("ph.flutter")
require("ph.lsp")
require("ph.lsp")
require("lualine").setup()
require("ph.tree")
require("ph.lazygit")
require('neorg').setup {
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.norg.dirman"] = { -- Manages Neorg workspaces
    config = {
      workspaces = {
        personal = "~/notes/personal",
        work = "~/notes/work",
      },
    },
  },
},
        }
