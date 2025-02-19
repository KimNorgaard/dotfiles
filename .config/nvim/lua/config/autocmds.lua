local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("buffer", {
	clear = true,
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = "buffer",
	pattern = { "*.md", "*.txt" },
	command = "setlocal spell spelllang=en_us,da",
	desc = "Spell check markdown files",
})

autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, [["]])
		if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
	desc = "open file with cursor on last position",
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

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})
