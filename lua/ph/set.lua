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

vim.keymap.set("n", "<Right>", "<CMD>bn<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<Left>", "<CMD>bp<CR>", { desc = "Go to previous buffer" })
