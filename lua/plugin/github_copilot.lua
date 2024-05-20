
local function main()
	-- Autocmd that disables copilot on every buffer 
	 -- vim.api.nvim_create_autocmd('LspAttach' ,{
	 -- 	callback = function ()
	 -- 		cmd("let b:copilot_enabled = 1")
	 -- 	end
	 -- })
	-- In this config file, the opposite can also be done: setting b:copilot_enabled=0 in buffer_settings and using b:copilot_enabled=1 to enable it via a shortcut.
	-- Source: https://github.com/orgs/community/discussions/57887#discussioncomment-7768432
	-- lua print(vim.inspect(vim.lsp.buf_get_clients()))

	local function enable_if_other_lsp_present()

		local on_attach = function(client, _bufnr)
			local active_buffers = vim.lsp.get_active_clients({bufnr = _bufnr})
			-- vim.lsp.get_active_clients({bufnr = _bufnr}) might be deprecated in a near future
			-- if this stops working out of nowhere, check if this is the cause.
			if type(active_buffers) ~= "table" or #active_buffers == 0 then return end

			local to_print = ""
			for _, client in ipairs(active_buffers) do
				-- to_print = to_print .. client.name .. " "
				if client.name ~= "GitHub Copilot" then
					cmd("execute 'buffer ' . ".._bufnr.."| let b:copilot_enabled = 1")
				end
			end
			-- print(to_print)

		end

		  local _start_client = vim.lsp.start_client
		  vim.lsp.start_client = 
		  function(config)
			    if config.on_attach == nil then
					    config.on_attach = on_attach
						  else
							      local old_on_attach = config.on_attach
								      config.on_attach = 
									  function(client, bufnr)
												on_attach		(client, bufnr)
												old_on_attach	(client, bufnr)
									  end
							end
			  return _start_client(config)
		  end
	end -- END hook

	-- EXEC
	kmn("<leader>cs", ":Copilot status<cr>")
	kmn("<leader>ce", ":let b:copilot_enabled = 1")
	kmn("<leader>cd", ":let b:copilot_enabled = 0")
	kmn("<leader>cd", ":let b:copilot_enabled = 0")
	cmd("au BufNewFile,BufRead * let b:copilot_enabled = 0")
	enable_if_other_lsp_present()
end	-- END main


local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\n Github Copilot -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'github/copilot.vim'
]])

plugin_add_config(function() xpcall(main, error_handler) end)

