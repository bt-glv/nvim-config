
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},

	ft = { "markdown","vimwiki", "pandoc" },

	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		preset = 'obsidian',
		code = {
			enabled = true,
			style   = 'full'
		},
		completions = {
			lsp = { enabled = true }
		},
	},

	-- config = function()
	-- 	require('render-markdown').setup({
	--
	-- 		preset = 'obsidian',
	-- 		code = {
	-- 			enabled = true,
	-- 			style   = 'full'
	-- 		},
	-- 		completions = {
	-- 			lsp = { enabled = true }
	-- 		},
	-- 	})
	-- end
}
