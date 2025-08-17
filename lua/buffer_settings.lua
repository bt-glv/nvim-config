
StatusLine = {
	path_relative = function()

		local full_path = vim.fn.expand('%:p')
		if full_path == '' or full_path == nil then return '[Unnamed]' end

		local buff_file_name = vim.fn.expand('%:t')
		local buff_path = vim.fn.expand('%:p:h')
		local working_directory = vim.fn.getcwd()

		if string.find(buff_path, '^'..working_directory) then
			if buff_file_name == 'NeogitStatus' then return '[Neogit]' end

			local relative_path = string.sub(buff_path, #working_directory + 1)
			local relative_path_with_file = relative_path..'/'..buff_file_name

			local out = (relative_path == '' or nil) and './'..buff_file_name or '.'..relative_path_with_file
			return out
		end

		if vim.b.current_syntax == 'oil' then
			local res = vim.fn.substitute(buff_path, [[^oil:[/]\?[/]\?]],"","g") -- I dont think vim regex is needed here
			res = vim.fn.substitute(res, "^"..vim.fn.expand('~'),'~','g')
			return res
		end

		if string.find(buff_path, '^'..'diffview://') then
			local res = vim.fn.substitute(full_path, [[^diffview:[/]\?[/]\?]],"","g")

			if string.find(res, '^.panels') then
				return '[DiffView]'
			end

			res = string.sub(res, #working_directory + 1)

			if string.find(res, '^.[.]git/') then
				return vim.fn.substitute(res, '^.[.]git[/][:].\\+[:][/]',"old::","g")
			end

			res = (res == '' or nil) and './'..buff_file_name or '.'..res..'/'..buff_file_name
			return res
		end

		return full_path
		--return buff_file_name
	end,

	lsp = function()
		local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
		local clients = vim.lsp.get_clients()

		if next(clients) == nil then return '' end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
				--return ' '..client.name
			end
		end

		return ''
	end,
}
--:help statusline
vim.opt.statusline = "%{v:lua.StatusLine.path_relative()} %w%h%m%r%= %{v:lua.StatusLine.lsp()} %l:%c %P "

--
-- # Buffer Settings
--

vim.g.netrw_bufsettings='noma nomod nu nobl nowrap ro'
-- Relative line numbers in netrw
-- what the hell is this even supposed to mean?

vim.opt.termguicolors=true
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.signcolumn = "no"
vim.opt.tabstop = 4 -- Defines indent spacing
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 4
vim.opt.updatetime = 50

