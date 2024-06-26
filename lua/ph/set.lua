local nmap = require("ph.keymap").nmap

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.colorcolumn = "80"
vim.opt.smartindent = true 
vim.opt.wrap = false
vim.g.noswapfile = true
vim.opt.swapfile = false

vim.g.mapleader = " "

nmap { "<Right>", "<cmd>bn<CR>" }
nmap { "<Left>", "<cmd>bp<CR>" }
