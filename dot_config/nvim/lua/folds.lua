local M = {}

M.foldtext = function()
	local start_line = vim.v.foldstart
	local end_line = vim.v.foldend
	local line_count = end_line - start_line + 1
	local summary = ""

	for lnum = start_line, end_line do
		local line = vim.fn.getline(lnum):gsub("\t", string.rep(" ", vim.bo.tabstop))
		line = line:gsub("%s+$", "")
		if line:match("%S") then
			summary = line
			break
		end
	end

	if summary == "" then
		summary = "..."
	end

	local suffix = string.format(" [%d lines]", line_count)
	local width = math.max(20, vim.api.nvim_win_get_width(0) - vim.fn.strdisplaywidth(suffix) - 6)
	if vim.fn.strdisplaywidth(summary) > width then
		summary = vim.fn.strcharpart(summary, 0, width - 3) .. "..."
	end

	return summary .. suffix
end

return M
