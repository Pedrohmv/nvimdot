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
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    personal = "~/notes/personal",
                    work = "~/notes/work",
                },
            },
        },
    },
}
require('dressing').setup({
    input = { enabled = false, }
})
