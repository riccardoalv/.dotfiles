local o = vim.o
vim.api.nvim_set_var("localmapleader", [[\]])
vim.api.nvim_set_var("mapleader", ",")
vim.cmd([[ set undodir=~/.dotfiles/nvim/undodir ]])
vim.g.editorconfig = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

o.ai = true
o.autoread = true
o.background = "dark"
o.backspace = "indent,eol,start"
o.backupext = ".bak"
o.completeopt = "menu,menuone,noselect"
o.cursorline = true
o.encoding = "utf-8"
o.equalalways = false
o.errorbells = false
o.expandtab = true
o.exrc = true
o.foldcolumn = "0"
o.foldenable = false
o.foldmethod = "expr"
o.hidden = true
o.history = 500
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.langmenu = "en"
o.laststatus = 2
o.magic = true
o.mat = 2
o.mouse = false
o.nrformats = "bin,octal,hex,alpha"
o.number = true
o.omnifunc = "syntaxcomplete#Complete"
o.path = ".,,,**"
o.pumblend = 0
o.ruler = false
o.sessionoptions = "buffers,curdir,folds,tabpages,winsize,terminal,options,localoptions"
o.shiftwidth = 2
o.shortmess = "filnxtToOFc"
o.showmatch = true
o.signcolumn = "yes"
o.siso = 10
o.si = true
o.smartcase = true
o.smarttab = true
o.so = 5
o.softtabstop = 2
o.spelllang = "en"
o.splitbelow = true
o.splitright = true
o.stal = 1
o.swapfile = false
o.switchbuf = "useopen,usetab,newtab"
o.tabstop = 2
o.termguicolors = true
o.undofile = true
o.visualbell = false
o.whichwrap = "<,>,h,l,b,s"
o.wildignore = "*.so, *.dll, *.swp, .egg, *.jar, *.class, *.pyc, *.pyo, *.bin, *.dex, node_modules"
o.wildmenu = true
o.winblend = 0
o.wrap = false
