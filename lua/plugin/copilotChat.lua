
local config = {
	'CopilotC-Nvim/CopilotChat.nvim',
	branch = 'canary',
	lazy = false,
	dependencies = {'github/copilot.vim'},
	config = function()

		require("CopilotChat").setup{
		window = {
			layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
			width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
			height = 0.3, -- fractional height of parent, or absolute height in rows when > 1
			-- Options below only apply to floating windows
			relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
			border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
			row = nil, -- row position of the window, default is centered
			col = nil, -- column position of the window, default is centered
			title = 'Copilot Chat', -- title of chat window
			footer = nil, -- footer of chat window
			zindex = 1, -- determines if window is on top or below other floating windows
		  },
		  mappings = {
			complete = {
			  detail = 'Use @<Tab> or /<Tab> for options.',
			  insert ='<Tab>',
			},
			close = {
			  normal = 'q',
			  insert = '<C-c>'
			},
			reset = {
			  normal ='<C-l>',
			  insert = '<C-l>'
			},
			submit_prompt = {
			  normal = '<CR>',
			  insert = '<C-m>'
			},
			accept_diff = {
			  normal = '<C-y>',
			  insert = '<C-y>'
			},
			yank_diff = {
			  normal = 'gy',
			},
			show_diff = {
			  normal = 'gd'
			},
			show_system_prompt = {
			  normal = 'gp'
			},
			show_user_selection = {
			  normal = 'gs'
			},
		  },
		} -- copilot_chat_config END

		kmn("<leader>cc", ":CopilotChatToggle<cr>")
		kmv("<leader>cc", "<Esc>:CopilotChatToggle<cr>")
		kmv("<leader>cst", "<Esc>:CopilotStop<cr>")
	end -- END Config function 
}
Lazy_plugin_add(config)


