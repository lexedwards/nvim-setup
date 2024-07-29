-- Set leader to <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Set tabs to Spaces (2)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Line Numbers
opt.cursorline = true
opt.number = true
