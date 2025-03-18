
return {
	'stevearc/oil.nvim',
	lazy = false,
	dependencies = {},
	config = function()

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

		local function pwc()
			local path = vim.fn.expand('%:p:h')
			path = vim.fn.substitute(path, "^oil:[/][/]","","g")
			vim.fn.system('echo "'..path..'"  | if command -v wl-copy >/dev/null 2>&1; then wl-copy; else xclip -selection clipboard; fi')
			print("Current folder path copied to clipboard")

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
				["<leader>pwc"] = function() pwc() end,
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
