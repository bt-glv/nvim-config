
-- TODO: Lazy load this
return {
	'sindrets/diffview.nvim',
	lazy = false,
	dependencies = {},
	config = function()
		cmd("command! Diff DiffviewOpen")
	end -- END Config function 
}
