local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.api.nvim_buf_set_keymap
local api = vim.api
local fn = vim.fn
local o = vim.opt

augroup("buffer", {
	clear = true,
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = "buffer",
	pattern = { "*.md", "*.txt" },
	command = "setlocal spell spelllang=en_us,da",
	desc = "Spell check markdown files",
})

autocmd("FileType", {
	group = "buffer",
	pattern = { "gitcommit", "gitrebase" },
	command = "startinsert | 1",
	desc = "Start git messages in insert mode",
})

augroup("hidelistcharsoninsert", {
	clear = true,
})

autocmd({ "InsertEnter" }, {
	group = "hidelistcharsoninsert",
	command = "set listchars-=trail:⌴ | set listchars-=eol:¬",
	desc = "Hide listchars on insert",
})

autocmd({ "InsertLeave" }, {
	group = "hidelistcharsoninsert",
	command = "set listchars+=trail:⌴ | set listchars+=eol:¬",
	desc = "Show listchars on insert",
})

local format_sync_grp = api.nvim_create_augroup("GoFormat", {})
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})
