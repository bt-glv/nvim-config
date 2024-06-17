
local function copilot_config()
	local function enable_if_other_lsp_present()

		local on_attach = function(client, _bufnr)
			local active_buffers = vim.lsp.get_active_clients({bufnr = _bufnr})
			-- vim.lsp.get_active_clients({bufnr = _bufnr}) might be deprecated in a near future
			-- if this stops working out of nowhere, check if this is the cause.
			if type(active_buffers) ~= "table" or #active_buffers == 0 then return end

			for _, client in ipairs(active_buffers) do
				if client.name ~= "GitHub Copilot" then
					cmd("execute 'buffer ' . ".._bufnr.."| let b:copilot_enabled = 1")
				end
			end

		end

		  local _start_client = vim.lsp.start_client
		  vim.lsp.start_client = function(config)
			    if config.on_attach == nil then
					    config.on_attach = on_attach
						  else
							      local old_on_attach = config.on_attach
								      config.on_attach = 
									  function(client, bufnr)
												old_on_attach	(client, bufnr)
												on_attach		(client, bufnr)
									  end
							end
			  return _start_client(config)
		  end
	end -- END hook

	-- EXEC
	kmn("<leader>cs", ":Copilot status<cr>")
	kmn("<leader>cp", ":Copilot panel<cr>")
	kmn("<leader>ce", ":let b:copilot_enabled = 1")
	--let b:workspace_folder = getcwd() 
	--let g:copilot_workspace_folders = ["".getcwd()]
	--cmd('let g:copilot_workspace_folders = ["".getcwd()]')
	cmd([[
	let g:copilot_filetypes = {
		\ 'txt': v:false,
		\ 'md': v:false,
		\ }
	]])
	cmd("au BufNewFile,BufRead * let b:copilot_enabled = 0")
	enable_if_other_lsp_present()
end	-- END main

local function copilot_chat_config()
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
	-- remaps here
	local function execute_if_copilot_buff(_if,_else,mode)
		Execute_if_buff("copilot-chat",_if,_else,mode) end

	-- kmn("<leader>cc", "<c-w>s<c-w>j:CopilotChat<cr>:resize 10<cr>")
	kmn("<leader>cc", ":CopilotChatToggle<cr>")
	kmv("<leader>cc", "<Esc>:CopilotChatToggle<cr>")
	kmv("<leader>cst", "<Esc>:CopilotStop<cr>")
	--[[
		TODO: Implement the following
		Commands
			:CopilotChat <input>? - Open chat window with optional input
			:CopilotChatOpen - Open chat window
			:CopilotChatClose - Close chat window
			:CopilotChatToggle - Toggle chat window
			:CopilotChatStop - Stop current copilot output
			:CopilotChatReset - Reset chat window
			:CopilotChatSave <name>? - Save chat history to file
			:CopilotChatLoad <name>? - Load chat history from file
			:CopilotChatDebugInfo - Show debug information
		Commands coming from default prompts
			:CopilotChatExplain - Write an explanation for the active selection as paragraphs of text
			:CopilotChatReview - Review the selected code
			:CopilotChatFix - There is a problem in this code. Rewrite the code to show it with the bug fixed
			:CopilotChatOptimize - Optimize the selected code to improve performance and readablilty
			:CopilotChatDocs - Please add documentation comment for the selection
			:CopilotChatTests - Please generate tests for my code
			:CopilotChatFixDiagnostic - Please assist with the following diagnostic issue in file
			:CopilotChatCommit - Write commit message for the change with commitizen convention
			:CopilotChatCommitStaged - Write commit message for the change with commitizen convention
	]]--
end

--
-- Exec
--
local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\n Github Copilot -> error processing main function/config\nMaybe its not installed?\n\n" .. err) 
end
plugin_add([[
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
]])

-- Config functions must be added individually
-- Otherwise, they might be executed in the wrong order
plugin_add_config(function() xpcall(copilot_chat_config, error_handler) end)
plugin_add_config(function() xpcall(copilot_config, error_handler) end)

