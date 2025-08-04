
return {
	'rcarriga/nvim-dap-ui',
	lazy = false,
	dependencies = {
	'mfussenegger/nvim-dap',
	"nvim-neotest/nvim-nio",
	'theHamsta/nvim-dap-virtual-text',
	},
	-- opts = {},
	config = function()
		-- temporary keymaps
		km('n', '<leader>dt', ':DapUiToggle<CR>', {noremap=true})
		km('n', '<leader>db', ':DapToggleBreakpoint<CR>', {noremap=true})
		km('n', '<leader>dc', ':DapContinue<CR>', {noremap=true})
		km('n', '<leader>dr', function() require('dapui').open({reset = true}) end, {noremap=true})
	end
}
