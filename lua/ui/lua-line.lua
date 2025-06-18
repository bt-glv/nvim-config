
local function lsp_info()
    local msg = ''
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()

    if next(clients) == nil then return msg end

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name..'  '
      end
    end

    return msg
end

local function cwd_path_relative()

	local cwd = vim.fn.getcwd()
	local buff_path = vim.fn.expand('%:h')
	local buff_name = vim.fn.expand('%:t')

	if string.find(buff_path, '^'..cwd) then

		local res = string.sub(buff_path, #cwd + 1)
		res = res..'/'..buff_name
		return res

	end

	return buff_name
end

-- DELETE this before commit
function TT() Notify(cwd_path_relative()) end


return {
    'nvim-lualine/lualine.nvim',
	lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {

		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = { function() return cwd_path_relative() end },
			lualine_x = { lsp_info },
			lualine_y = {'progress'},
			lualine_z = {'location'}
	  	},
	},
}



