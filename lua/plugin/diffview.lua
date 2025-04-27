
-- TODO: Lazy load this
return {
	'sindrets/diffview.nvim',
	lazy = false,
	dependencies = {},
	config = function()
		cmd("command! Diff DiffviewOpen")
		km('n', '<leader>nd', ':DiffviewOpen<cr>')
	end -- END Config function 
}
