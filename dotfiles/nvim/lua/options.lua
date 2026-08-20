vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.background = "dark"

vim.opt.laststatus = 3

vim.diagnostic.config { virtual_text = true, virtual_line = false }

vim.cmd "colorscheme vscode"
