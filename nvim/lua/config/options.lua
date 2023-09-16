local o = vim.o

-- Set general options
o.mouse = false
o.cursorline = true
o.ruler = true
o.hidden = true
o.backspace = "indent,eol,start"
o.whichwrap = "<,>,h,l,b,s"
o.completeopt = "menu,menuone,noselect"
o.shortmess = "filnxtToOFc"
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.inccommand = "split"
o.magic = true
o.showmatch = true
o.mat = 2
o.so = 5
o.siso = 10
o.splitright = true
o.splitbelow = true
o.foldenable = false
o.foldcolumn = "0"
o.signcolumn = "yes"
o.foldmethod = "expr"
o.number = true
o.backupext = ".bak"
o.equalalways = false
o.undofile = true
o.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal,options,localoptions,winpos,resize"
vim.cmd([[ set undodir=~/.dotfiles/nvim/undodir ]])

-- Font options
o.gfn = "Ubuntu Mono Regular"

-- Colorscheme
o.background = "dark"
o.termguicolors = true
o.pumblend = 10
o.winblend = 10

-- Use spaces instead of tabs
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.ai = true
o.si = true
o.wrap = false
vim.g.editorconfig = false

-- History
o.history = 500
o.swapfile = false

-- Set to auto read when a file is changed from the outside
o.autoread = true

-- Omnifunc
o.omnifunc = "syntaxcomplete#Complete"

-- Language
o.langmenu = "en"
o.spelllang = "en"
o.encoding = "utf-8"

-- Turn on the Wild menu
o.wildmenu = true
-- Ignore compiled files
o.wildignore = "*.so, *.dll, *.swp, .egg, *.jar, *.class, *.pyc, *.pyo, *.bin, *.dex, node_modules"
o.path = ".,,,**"
o.exrc = true

-- No annoying sound on errors
o.errorbells = false
o.visualbell = false

-- Specify the behavior when switching between buffers
o.switchbuf = "useopen,usetab,newtab"
o.stal = 1

-- Always show the status line
o.laststatus = 2

-- Increment
o.nrformats = "bin,octal,hex,alpha"

-- Sessions Options
o.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal,options,localoptions"
