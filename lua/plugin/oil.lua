
return {
	'stevearc/oil.nvim',
	lazy = false,
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()

		Exit_to_file_path = function()
			local current_file_path = vim.fn.expand('%:p:h')

			if current_file_path == '' or current_file_path == nil then return end
			current_file_path = vim.fn.substitute(current_file_path, "^oil:[/][/]","","g")

			local file_nvim_quit = io.open(os.getenv("HOME") .. "/.file_nvim_quit", "w")
			if file_nvim_quit then
				file_nvim_quit:write(current_file_path)
				file_nvim_quit:close()
			end

			vim.cmd('qa!')
		end

		local function pwc()
			local current_file_path = vim.fn.expand('%:p:h')
			current_file_path = vim.fn.substitute(current_file_path, "^oil:[/][/]","","g")

			-- Does not work with wl-clipboard and xclip are installed
			-- on the same computer.
			-- vim.cmd("silent! !echo '"..current_file_path.."' | if command -v wl-copy >/dev/null 2>&1; then wl-copy; else xclip -selection clipboard; fi ")

			local x_command = [[
				function pwc() {
					_wl_clipboard=false;
					_xclip=false;

					if which xclip >/dev/null 2>&1; then _xclip=true; fi
					if which wl-copy >/dev/null 2>&1; then _wl_clipboard=true; fi

					if { [ "$_wl_clipboard" = true ] || [ "$_xclip" = true ]; } && { [ "$_xclip" != true ] || [ "$_wl_clipboard" != true ]; }; then
							echo ']]..current_file_path..[[' | xclip -selection clipboard >/dev/null 2>&1 || echo "$(pwd)" | wl-copy >/dev/null 2>&1;
							return 0;
					fi

					echo ']]..current_file_path..[[' | xclip -selection clipboard >/dev/null 2>&1
					echo ']]..current_file_path..[[' | wl-copy >/dev/null 2>&1 || echo "$(pwd)" | wl-copy >/dev/null 2>&1
					return 0
				}
				pwc;]]

			local async = require("plenary.async")
			local Job = require("plenary.job")

			local function run_ls_async()
			  async.run(function()
				-- Run the command and wait for result
				Job:new({
				  command = "bash",
				  args = {'-c', x_command},
				  on_exit = function(j) print('on exit') end,
				}):sync()
			  end)
			end

			-- run_ls_async()
			vim.fn.jobstart({'bash','-c', 'echo "$(pwd)"'}, {
				stdout_buffered = true,
				  on_stdout = function(i, data, x)
					if data then
					  for _, line in ipairs(data) do
						print(line)
					  end
					end
				  end,
				  on_stderr = function(_, data, _)
					if data then
					  for _, line in ipairs(data) do
						vim.api.nvim_err_writeln(line)
					  end
					end
				  end,
				  on_exit = function(i, code, x)
					-- print("code:" ..code.."   i:" ..i.."   x:" ..x)
				  end
			})

			--vim.fn.system(x_command)
			print("Current folder path copied to clipboard")
		end

		local function pg()
			-- get current clipboard contents
			-- oil cd to that directory if on oil buffer
			local clipboard = vim.fn.getreg('+')
			clipboard = vim.fn.substitute(clipboard, [[\_s$]],"","g")
			require("oil").open(clipboard)
		end


		local function telescope_goto_folder()
			local cwd 			= vim.fn.getcwd()
			local actions 		= require("telescope.actions")
			local action_state 	= require("telescope.actions.state")
			local pickers 		= require("telescope.pickers")
			local finders 		= require("telescope.finders")
			local config 		= require("telescope.config").values


		  pickers.new({}, {
			prompt_title = "Go to folder",
			finder = finders.new_oneshot_job({ "fd", "-t", "d", "--hidden", "--exclude", ".git"}, { cwd = vim.fn.getcwd() }),
			sorter = config.generic_sorter({}),

			attach_mappings = function(prompt_bufnr, _)
			  actions.select_default:replace(function()
				actions.close(prompt_bufnr)
					local results = vim.fn.getcwd().."/"..action_state.get_selected_entry()[1]
					require("oil").open(results)
			  end)
				print(vim.inspect(action_state.get_selected_entry()))
			  return true
			end,
		  }):find()
		end


		local function telescope_goto_file_folder()
			local cwd 			= vim.fn.getcwd()
			local actions 		= require("telescope.actions")
			local action_state 	= require("telescope.actions.state")
			local pickers 		= require("telescope.pickers")
			local finders 		= require("telescope.finders")
			local config 		= require("telescope.config").values


		  pickers.new({}, {
			prompt_title = "Go to file folder",
			finder = finders.new_oneshot_job({ "fd", "--hidden", "--exclude", ".git" }, { cwd = vim.fn.getcwd() }),
			sorter = config.generic_sorter({}),

			-- s/[/][^/]\+$//g
			attach_mappings = function(prompt_bufnr, _)
			  actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local pick = action_state.get_selected_entry()[1]
					pick = vim.fn.substitute(pick, [[[/][^/]\+$]], "", "g" )

					local results = vim.fn.getcwd().."/"..pick
					require("oil").open(results)
			  end)
				print(vim.inspect(action_state.get_selected_entry()))
			  return true
			end,
		  }):find()
		end


			require("oil").setup({
			  default_file_explorer = true,
			  columns = {
				"icon",
			  },
			  buf_options = {
				buflisted = false,
				bufhidden = "hide",
			  },
			  win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			  },
			  delete_to_trash = false,
			  skip_confirm_for_simple_edits = false,
			  prompt_save_on_select_new_entry = true,
			  cleanup_delay_ms = 2000,
			  lsp_file_methods = {
				timeout_ms = 1000,
				autosave_changes = false,
			  },
			  constrain_cursor = "editable",
			  experimental_watch_for_changes = false,
			  keymaps = {
				["<leader>pg"] = function() pg() end,
			  	["<leader>pwc"] = function() pwc() end,
				["<leader>="] = function() telescope_goto_folder() end,
				["<leader>-"] = function() telescope_goto_file_folder() end,
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd", -- Goes to the dir saved by "="
				["="] = "actions.cd",		-- Saves a dir
				["+"] = "actions.tcd",
				["~"] = false,
				["`"] = false,
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			  },
			  use_default_keymaps = true,
			  view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
				  return vim.startswith(name, ".")
				end,
				is_always_hidden = function(name, bufnr)
				  return false
				end,
				natural_order = true,
				sort = {
				  { "type", "asc" },
				  { "name", "asc" },
				},
			  },
			  extra_scp_args = {},
			  git = {
				add = function(path)
				  return false
				end,
				mv = function(src_path, dest_path)
				  return false
				end,
				rm = function(path)
				  return false
				end,
			  },
			  float = {
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
				  winblend = 0,
				},
				override = function(conf)
				  return conf
				end,
			  },
			  preview = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
				  winblend = 0,
				},
				update_on_cursor_moved = true,
			  },
			  progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
				  winblend = 0,
				},
			  },
			  ssh = {
				border = "rounded",
			  },
			  keymaps_help = {
				border = "rounded",
			  },
			})



		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>vp", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		-- For global use
		-- vim.keymap.set("n", "<leader>=", function() telescope_goto_folder() end)

	end -- END Config function
}
