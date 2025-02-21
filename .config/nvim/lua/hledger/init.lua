-- formatexpr

local M = {}

function M.hledger_align_entry(total_width, line)
	total_width = total_width or vim.g.ledger_align_at or 60

	local function split_string(str)
		local amount, comment = string.match(str, "^(.-);%s*(.*)$")
		if not comment then
			amount = string.match(str, "^(.-)$")
			comment = ""
		end
		amount = string.match(amount, "^%s*(.-)%s*$") -- Trim amount
		comment = string.match(comment, "^%s*(.-)%s*$") -- Trim comment
		return amount, comment
	end

	-- Helper function to align a single entry
	local function align_entry(entry)
		-- Extract the indentation, account name, and amount parts
		local indentation, account, amount = string.match(entry, "^(%s+)([^;%s].+%s+)%s(.+)$")

		if not account or not amount then
			return entry -- Return the original entry if it doesn't match the pattern
		end

		local comment
		amount, comment = split_string(amount)

		if comment ~= "" then
			comment = " ; " .. comment
		end

		-- Calculate the width of the account part
		local account_width = vim.fn.strdisplaywidth(account)

		-- Calculate the width of the amount part
		local amount_width = vim.fn.strdisplaywidth(amount)

		-- Calculate the number of spaces needed to align the amount part
		local spaces_needed = total_width - account_width - amount_width

		-- Construct the aligned string
		return indentation .. account .. string.rep(" ", spaces_needed) .. amount .. comment
	end

	local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
	local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]
	if start_line > 0 and end_line > 0 then
		for line_num = start_line, end_line do
			local entry = vim.fn.getline(line_num)
			local aligned_entry = align_entry(entry)
			vim.fn.setline(line_num, aligned_entry)
		end
	else
		-- use specified line or current line
		local line_num = line or vim.fn.line(".")
		local entry = vim.fn.getline(line_num)
		local aligned_entry = align_entry(entry)
		vim.fn.setline(line_num, aligned_entry)
	end
	vim.schedule(function()
		vim.api.nvim_buf_set_mark(0, "<", 0, 0, {})
		vim.api.nvim_buf_set_mark(0, ">", 0, 0, {})
	end)
end

function M.hledger_align_buffer()
	local buffer = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, true)

	for num, _ in ipairs(lines) do
		M.hledger_align_entry(nil, num)
	end
end

return M
