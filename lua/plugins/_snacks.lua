
------
-- Autocmds
------

-- Disable indent guides from snacks.indent
local snacks_autocmd_group = vim.api.nvim_create_augroup("snacks_custom", {clear = true})
vim.api.nvim_create_autocmd(
	{ "FileType", "BufFilePost"},
	{
		group    = snacks_autocmd_group,
		pattern  = '*',
		callback = function(args)
			local ignore = { markdown = true, }
			if(ignore[vim.bo[args.buf].filetype] == true) then
				vim.b[args.buf].snacks_indent = false
			end
		end,
	}
)


-------
-- Custom pickers
-------

local function spellsuggest_picker()
	local word = vim.fn.expand("<cword>")
	if not word or word == "" then
		vim.notify("No word under cursor", vim.log.levels.WARN)
		return
	end

	local suggestions = vim.fn.spellsuggest(word, 25)
	if #suggestions == 0 then
		vim.notify("No spelling suggestions for: " .. word, vim.log.levels.INFO)
		return
	end

	local items = {}
	for idx, s in ipairs(suggestions) do
		table.insert(items, {
			idx = idx,
			word = s,
			-- snacks matches against `text`: include both index and word
			text = string.format("%d %s", idx, s),
		})
	end

	Snacks.picker({
		title = 'Spelling: "' .. word .. '"',
		items = items,
		format = function(item)
			return {
				{ string.format("%2d. ", item.idx), "Comment" },
				{ item.word, "Normal" },
			}
		end,
		layout = {
			preset = "select",
		},
		confirm = function(picker, item)
			picker:close()
			if item and item.word then
				-- item.word is completely untouched and clean
				vim.cmd('normal! "_ciw' .. item.word)
			end
		end,
	})
end


-------
-- Keymap function definitions
-------

local picker_keymaps = function()
	if TelescopeOrSnacks then return end

	local Snacks = require('snacks')

	km("n", "<leader>fs", 	function() Snacks.picker.smart() 		    end)
	km("n", "<leader>ff", 	function() Snacks.picker.files() 		    end)
	km("n", "<leader>fb", 	function() Snacks.picker.buffers() 		    end)
	km("n", "<leader>fl", 	function() Snacks.picker.grep() 		    end)
	km("n", "<leader>fr", 	function() Snacks.picker.registers() 	    end)
	km("n", "<leader>fu", 	function() Snacks.picker.undo()             end)
	km("n", "<leader>fm", 	function() Snacks.picker.marks()            end)
	-- km("n", "<leader>fh", 	function() end) -- WIP: current buffer fuzzy find
end
local notifyer_keymaps = function()
	km('n', '<leader><CR>', function() Snacks.notifier.show_history() end)
end


------
-- Plugin config object
------

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy     = false,
	config   = function()

		local Snacks = require('snacks')
		Snacks.setup({

			indent = {
				priority     = 1,
				enabled      = true,
				char         = "▏",
				only_scope   = false, -- only show indent guides of the scope
				only_current = false, -- only show indent guides in the current window
				hl           = "SnacksIndent", ---@type string|string[] hl groups for indent guides
			},

			animate = {
				enabled  = false,
				style    = "out",
				easing   = "linear",
				duration = {
					step = 20, -- ms per step
					total = 500, -- maximum duration
				},
			},

			chunk = {
				enabled      = false,
				only_current = false,
				priority     = 200,
				hl           = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
				char = {
					corner_top    = "┌",
					corner_bottom = "└",
					horizontal    = "─",
					vertical      = "│",
					arrow         = ">",
				},
			},

			notifier = {
				enabled = true,
			},

			image = {
				enabled = true,
				doc = {
					inline     = true,
					float      = true,
					max_width  = 80,
					max_height = 40,
				},
				-- Images must be placed in a folder with one of the following names at the root of the current working directory
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments"
				},
				math = {
					enabled = true,
				},
			},

			picker = {
				enabled = not TelescopeOrSnacks,
			}
		})

		---@param string string Notification Body
		---@param priority number Priority 1 - 6; 4:error, 6:bug
		---@param opts {title: string} Aditional parameters, such as Title
		-- This is a replacemnt for the original notify funciton.
		-- Snacks notify module.
		Notify = function(string, priority, opts)
			opts          = (type(opts )== 'table') and opts or {}
			priority      = priority or 6
			opts['title'] = opts['title'] or 'Notify'

			-- fun(msg: string, level?: Snacks.notifier.level|number, opts?: Snacks.notifier.Notif.opts): number|string
			Snacks.notifier(string, priority, opts)
		end


		-------
		-- Keymap functions calls / keymap definitions
		-------

		picker_keymaps()
		notifyer_keymaps()
		vim.keymap.set("n", "z<leader>", spellsuggest_picker, { desc = "Snacks Spell Suggest" })
	end
}

