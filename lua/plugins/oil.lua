
return {
    'stevearc/oil.nvim',
    lazy         = false,
    dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
	},

    config = function()

        Tools.Global.exit_to_file_path = function()
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

		local function working_directory_here()
			if not vim.b.current_syntax == 'oil' then return end
			local path = vim.fn.substitute(vim.fn.expand("%:h"), [[^oil:[/]\?[/]\?]],"","g")
			vim.fn.chdir(path)
			Notify("New Working Directory:\n"..path, 3, {Title = "[Oil]"})
		end

		--- Copies oil buffer's path to the clipboard
		local function path_buffer()
			local current_file_path = require'oil'.get_current_dir()
			vim.fn.setreg('+', current_file_path)
			print("[Oil] BUFFER path copied to the Clipboard")
		end

		local function path_entry_under_cursor()
			local oil   = require("oil")
			local entry = oil.get_cursor_entry()
			local path  = oil.get_current_dir()

			if not entry or not path then return end

			local full_path = path .. entry.name
			vim.fn.setreg("+", full_path)
			print("[Oil] ENTRY path copied to the Clipboard")
		end

		local function path_buffer_relative_to_project()
			local current_file_path = vim.fn.expand('%:p:h')
			local cwd = vim.fn.getcwd()
			current_file_path = vim.fn.substitute(current_file_path, "^oil:[/][/]"..cwd,"","g")

			vim.fn.setreg('+', current_file_path)
			print("[Oil] RELATIVE PATH copied to the Clipboard")
		end

		--- CDs to the clipboard path
		--- [!Attention] no input sanitization
		local function path_goto()
			local clipboard = vim.fn.getreg('+')
			clipboard = vim.fn.substitute(clipboard, [[\_s$]],"","g")
			require("oil").open(clipboard)
		end


		--- Searches for a folder and CDs into it
		local function telescope_goto_folder()
			local cwd 			= vim.fn.getcwd()
			local actions 		= require("telescope.actions"      )
			local action_state 	= require("telescope.actions.state")
			local pickers 		= require("telescope.pickers"      )
			local finders 		= require("telescope.finders"      )
			local config 		= require("telescope.config"       ).values


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
					return true
				end,
			}):find()
		end


		--- Searches for a file and CDs into its folder
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

				attach_mappings = function(prompt_bufnr, _)
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)

						local pick = action_state.get_selected_entry()[1]
						pick = vim.fn.substitute(pick, [[[/][^/]\+$]], "", "g" )

						local results = vim.fn.getcwd().."/"..pick
						require("oil").open(results)
					end)
					return true
				end,
			}):find()
		end

		-- TODO
		local function telescope_open_in_external_program()
			if (SystemOS ~= "Linux") then return end

			local oil   = require("oil")
			local entry = oil.get_cursor_entry()
			local dir   = oil.get_current_dir()

			if not entry or not dir then
				Notiy("No file selected", vim.log.levels.WARN)
				return
			end

			local file_path = dir .. entry.name
			local apps      = Tools.Linux.get_apps(file_path)

			local pickers      = require("telescope.pickers")
			local finders      = require("telescope.finders")
			local conf         = require("telescope.config").values
			local actions      = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			pickers.new({}, {
				prompt_title = "Open With (Linux Apps)",

				finder = finders.new_table({
					results     = apps,
					entry_maker = function(item)
						return {
							value   = item,
							display = item.name,
							ordinal = item.name,
						}
					end,
				}),

				sorter = conf.generic_sorter({}),

				attach_mappings = function(prompt_bufnr, _)
					actions.select_default:replace(function()

						actions.close(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						if not selection then return end

						local item = selection.value
						local spawn_cmd

						if item.desktop then
							if vim.fn.executable("gtk-launch") == 1 then
								spawn_cmd = { "gtk-launch", item.desktop, file_path }
							else
								spawn_cmd = { "gio", "launch", item.desktop, file_path }
							end
						else
							spawn_cmd = item.cmd
						end

						-- non blocking erro message
						vim.system(spawn_cmd, { detach = true }, function(obj)
							if obj.code ~= 0 and obj.stderr and #obj.stderr > 0 then
								vim.schedule(function()
									vim.notify("Error: " .. obj.stderr, vim.log.levels.ERROR)
								end)
							end
						end)

						vim.notify("Opening with " .. item.name .. "...")
					end)
					return true
				end,
			}):find()

		end

		vim.g.oil_toggle = false
		local function oil_toggle_full_view()

			local oil = require('oil')
			if not vim.g.oil_toggle then
				oil.set_columns({ "icon", "permissions", "size", "mtime" })
				vim.g.oil_toggle=true
				return
			end
			oil.set_columns({ "icon" })
			vim.g.oil_toggle=false
		end

		km('n', '<leader>-', telescope_goto_file_folder)
		km('n', '<leader>=', telescope_goto_folder)


		require("oil").setup({
			default_file_explorer = true,

			columns = { -- all possible options are listed below
				"icon",
				--'size',
				--'mtime',
				--'ctime',
				--'atime',
				--'birthtime',
				--'permissions',
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			win_options = {
				wrap          = false,
				signcolumn    = "no",
				cursorcolumn  = false,
				foldcolumn    = "0",
				spell         = false,
				list          = false,
				conceallevel  = 3,
				concealcursor = "nvic",
			},
			delete_to_trash                 = false,
			skip_confirm_for_simple_edits   = false,
			prompt_save_on_select_new_entry = true,
			cleanup_delay_ms                = 2000,
			lsp_file_methods = {
				enabled          = true,
				timeout_ms       = 1000,
				autosave_changes = false,
			},
			constrain_cursor = "editable",
			-- attention: might cause problems
			watch_for_changes = true,
			keymaps = {
				["<leader>pg"]   =  {
					callback = path_goto ,
					desc = "CDs do the path in clipbard.",
				},
				["<leader>pwc"]  =  {
					callback = path_buffer ,
					desc = "Copy current buffer's path to the clipboard.",
				},
				["<leader>epwc"] =  {
					callback = path_entry_under_cursor,
					desc = "Copy the path of the entry under the cursor to the clipboard.",
				},
				["<leader>rpwc"] =  {
					callback = path_buffer_relative_to_project,
					desc = "Copy the buffer's path relative to the project folder.",
				},
				["<leader>="]    =  {
					callback = telescope_goto_folder ,
					desc = "Telescope: CDs into the selected folder.",
				},
				["<leader>-"]    =  {
					callback = telescope_goto_file_folder ,
					desc = "Telescope: CDs into the selected file's folder.",
				},
				["<CR>"]         =  "actions.select",
				["<leader>cd"]   =  working_directory_here,
				["<C-s>"]        =  {
					callback = oil_toggle_full_view ,
					desc = "Toggle details.",
				},
				["<A-CR>"] = {
					callback = telescope_open_in_external_program,
					desc = "Telescope: pick external program to open file.",
				},
				["<C-CR>"] = "actions.open_external",

				--["<C-s>"] = "actions.select_vsplit",
				--["<C-h>"] = "actions.select_split",
				--["<C-t>"] = "actions.select_tab",
				--["<C-p>"] = "actions.preview",
				["g?"]    = "actions.show_help",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"]     = "actions.parent",
				["_"]     = "actions.open_cwd", -- Goes to the dir saved by "="
				["="]     = "actions.cd",		-- Saves a dir
				["+"]     = "actions.tcd",
				["~"]     = false,
				["`"]     = false,
				["gs"]    = "actions.change_sort",

				["g."]  = "actions.toggle_hidden",
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
				padding    = 2,
				max_width  = 0,
				max_height = 0,
				border     = "rounded",
				win_options = {
					winblend = 0,
				},
				override = function(conf)
					return conf
				end,
			},
			preview = {
				max_width  = 0.9,
				min_width  = { 40, 0.4 },
				width      = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height     = nil,
				border     = "rounded",
				win_options = {
					winblend = 0,
				},
				update_on_cursor_moved = true,
			},
			progress = {
				max_width        = 0.9,
				min_width        = { 40, 0.4 },
				width            = nil,
				max_height       = { 10, 0.9 },
				min_height       = { 5, 0.1 },
				height           = nil,
				border           = "rounded",
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

		vim.keymap.set("n", "-", "<CMD>Oil<CR>",          { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>vp", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end
}
