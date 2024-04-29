vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.opt.clipboard:append("unnamedplus")

-- Keymaps
vim.cmd('command! -nargs=0 W lua vim.cmd(":w")')
