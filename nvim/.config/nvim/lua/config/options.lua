-- =============================================================================
-- Options
-- =============================================================================

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

local opt = vim.opt

-- Files
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.breakindent = true

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.conceallevel = 0

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Mouse
opt.mouse = "a"

-- Encoding
opt.fileencoding = "utf-8"

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- Misc
opt.shortmess:append("c")
opt.iskeyword:append("-")
