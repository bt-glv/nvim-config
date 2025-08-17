
return {
	'mfussenegger/nvim-dap',
	event = 'VeryLazy', -- temporary
	dependencies = {
		"nvim-neotest/nvim-nio",

		-- debugger UI
		'rcarriga/nvim-dap-ui',

		-- Renders variable values on the buffer
		'theHamsta/nvim-dap-virtual-text',

		-- Fully handles "delve" debbuger required config
		'leoluz/nvim-dap-go',
	},
	opts = {},

	-- docs to set up debuggers
	-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	config = function()
		require("dap-go").setup()
		local dapui = require('dapui')
		dapui.setup()

		-- TODO: add remaps for: stopping
		-- TODO: dapuitoggle 
		km('n', '<leader>dt', function() dapui.toggle() end , 	{noremap=true})
		km('n', '<leader>dC', function() dapui.close() end , 	{noremap=true})
		km('n', '<leader>db', ':DapToggleBreakpoint<CR>', 		{noremap=true})
		km('n', '<leader>dc', ':DapContinue<CR>', 				{noremap=true})
		km('n', '<leader>dr', function() dapui.open({reset = true}) end, {noremap=true})
	end
}
