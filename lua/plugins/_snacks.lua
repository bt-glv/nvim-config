

local snacks_autocmd_group = vim.api.nvim_create_augroup("snacks_custom", {clear = true})
vim.api.nvim_create_autocmd(
	{ "FileType", "BufFilePost"},
	{
		group = snacks_autocmd_group,
		pattern = '*',
		callback = function(args)

			local ignore = {
				markdown = true,
			}

			if(ignore[vim.bo[args.buf].filetype] == true) then
				vim.b[args.buf].snacks_indent = false
			end

			-- vim.notify('callback: '..args.buf..'  -   '..vim.bo[args.buf].filetype)
		end,
	}
)

km('n', '<leader><CR>', function() require('snacks').notifier.show_history() end)
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy     = false,
	config   = function()
		local snacks = require('snacks')
		snacks.setup({
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
				}
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

			--fun(msg: string, level?: snacks.notifier.level|number, opts?: snacks.notifier.Notif.opts): number|string
			snacks.notifier(string, priority, opts)
		end

	end

}

