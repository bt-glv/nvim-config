
return {
	'github/copilot.vim',
	lazy = false,
	config = function()

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

	end -- END Config function
}
