local function augroup(name)
  return vim.api.nvim_create_augroup("autocmd_" .. name, { clear = true })
end

git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
if git_dir ~= "" then
  vim.cmd("cd " .. git_dir)
end

-- Git Dir
vim.api.nvim_create_autocmd("DirChanged", {
  group = augroup("git_dir"),
  callback = function()
    git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = true }
  end
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_set_var("vimsyn_embed", "lPr")
vim.g["markdown_fenced_languages"] = { "html", "python", "ruby", "vim", "javascript", "json", "css" }
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = augroup("hilight_white_spaces"),
  callback = function(event)
    vim.fn.matchadd("TrailingWhitespace", [[\v\s+$]])
    vim.cmd("hi TrailingWhitespace ctermbg=red guibg=red")
  end,
})
