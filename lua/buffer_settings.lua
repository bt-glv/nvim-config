
StatusLine = {
	path_relative = function()

		local cwd = vim.fn.getcwd()
		local buff_path = vim.fn.expand('%:p:h')
		local buff_name = vim.fn.expand('%:t')

		if string.find(buff_path, '^'..cwd) then
			local res = string.sub(buff_path, #cwd + 1)
			res = (res ~= '') and res..'/'..buff_name or '/'..buff_name
			return '.'..res
		end

		if vim.b.current_syntax == 'oil' then
			local res = vim.fn.substitute(buff_path, "^oil:[/][/]","","g") -- I dont think vim regex is needed here
			res = vim.fn.substitute(res, "^"..vim.fn.expand('~'),'~','g')
			return res
		end

		return vim.fn.expand('%:p')
		--return buff_name
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
vim.opt.statusline = "%{v:lua.StatusLine.path_relative()} %R%M%= %{v:lua.StatusLine.lsp()}  %l:%c %P "



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
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 4
vim.opt.updatetime = 50

