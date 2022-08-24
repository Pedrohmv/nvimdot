require("nvim-tree").setup()
local nmap = require("ph.keymap").nmap

nmap { "<c-b>", "<cmd>NvimTreeToggle<CR>" }
nmap { "<c-n>", "<cmd>NvimTreeFindFile<CR>" }
