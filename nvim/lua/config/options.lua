-- Editor options (ported from vimrc + modern defaults)
local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- System clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0
opt.confirm = true -- Confirm before closing unsaved buffer
opt.cursorline = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- UI
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.showmode = false -- Shown in statusline
opt.showcmd = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.laststatus = 3 -- Global statusline
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.winminwidth = 5

-- Indentation
opt.autoindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "nosplit" -- Preview substitutions

-- Files
opt.autoread = true
opt.autowrite = true
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.undolevels = 10000
opt.hidden = true

-- Performance
opt.updatetime = 200
opt.timeoutlen = 800
opt.ttimeoutlen = 0
opt.redrawtime = 1500
opt.lazyredraw = true

-- Completion
opt.pumheight = 10
opt.pumblend = 10
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Misc
opt.backspace = "indent,eol,start"
opt.joinspaces = false
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Folding (using treesitter)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Allow project-local config (like your old 'set exrc')
opt.exrc = true

-- Leader key is set in init.lua (must be before lazy.nvim loads)
