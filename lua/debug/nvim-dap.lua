
return {
	'mfussenegger/nvim-dap',
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


	-- review this
	keys = {
		{'<leader>ui', nil, mode = 'n'},
	},
	cmd = {
		-- 'DapToggleBreakpoint',
		-- 'DapContinue',
	},

	-- docs to set up debuggers
	-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	config = function()
		require("dap-go").setup()
		local dapui = require('dapui')
		local dap = require('dap')
		dapui.setup()

		-- TODO: test those remaps
		km('n', '<leader>ui', function() dapui.toggle() end , 	{noremap=true})

		km('n', '<F5>',     dap.continue, { desc = 'Debug: Start/Continue' })
		km('n', '<S-F5>',   dap.terminate, { desc = 'Debug: Stop' })
		km('n', '<C-S-F5>', dap.restart, { desc = 'Debug: Restart' })

		km('n', '<F10>',   dap.step_over, { desc = 'Debug: Step Over' })
		km('n', '<F11>',   dap.step_into, { desc = 'Debug: Step Into' })
		km('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })

		km('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })

		km('n', '<S-F9>', function()
			dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end, { desc = 'Debug: Conditional Breakpoint' })

	end
}
