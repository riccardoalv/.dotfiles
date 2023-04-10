local o = vim.o

function StatusClipboard()
	if o.clipboard == "unnamedplus" then
		o.clipboard = ""
	else
		o.clipboard = "unnamedplus"
	end
end

-- .vim file functions
function GitDir()
	local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
	local result = handle:read("*a")
	handle:close()
	result = result:gsub("[\n\r]", "")
	return result
end

vim.cmd("silent! source " .. GitDir() .. "/.nvim.lua")

-- Alias
vim.cmd([[
fun! Alias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
]])

-- commands
vim.cmd([[ command W w ]])

-- filetype plugin
vim.cmd([[filetype plugin on]])
vim.cmd([[filetype indent on]])

vim.cmd([[au FocusGained,BufEnter * checktime]])

-- Return to last position
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
vim.cmd([[autocmd InsertLeave * setl relativenumber]])
vim.cmd([[autocmd InsertEnter * setl norelativenumber]])

-- Enable syntax highlighting
vim.cmd([[ syntax enable ]])
vim.cmd([[ syntax on ]])
vim.api.nvim_set_var("vimsyn_embed", "lPr")
vim.g["markdown_fenced_languages"] = { "html", "python", "ruby", "vim", "javascript", "json", "css" }
vim.cmd([[ au VimEnter * hi TrailingWhitespace ctermbg=red guibg=red ]])
vim.fn.matchadd("TrailingWhitespace", [[\v\s+$]])

-- Let 'tl' toggle between this and the last accessed tab
vim.api.nvim_set_var("lasttab", 1)
vim.cmd([[au TabLeave * let g:lasttab = tabpagenr()]])

-- Auto open quickfix window
vim.cmd([[autocmd QuickFixCmdPost [^l]* nested cwindow]])
vim.cmd([[autocmd QuickFixCmdPost    l* nested lwindow]])