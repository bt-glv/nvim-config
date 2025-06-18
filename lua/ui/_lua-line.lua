
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

local function wd_path_relative()

	-- TODO
	-- if buffer file is in cwd do:
	-- path = get full buf file path
	-- path = search and replace (path, cwd)
	-- return path

	-- might be useful for making my own relative file path render
	-- print(vim.fn.getcwd())
	-- this get the current working directory
end


return {
    'nvim-lualine/lualine.nvim',
	lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {

		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = { lsp_info },
			lualine_y = {'progress'},
			lualine_z = {'location'}
	  	},
	},
}



