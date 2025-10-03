

return {
	'hrsh7th/nvim-cmp',
	lazy = false,
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
		{ -- this adds luasnip as a completion source for nvim.cmp
			"saadparwaiz1/cmp_luasnip",
			commit = '98d9cb5c2c38532bd9bdb481067b20fea8f32e90'
		},
	},
	config = function()
		local cmp = require('cmp')
		local luasnip = require('luasnip')

		cmp.setup( {
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				-- ['<C-a>'] = cmp.mapping.complete(),
				['<C-j>'] = cmp.mapping.scroll_docs(-4),
				['<C-k>'] = cmp.mapping.scroll_docs(4),


				-- default autocomplete selection commands
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-e>'] = cmp.mapping.abort(),

				-- ['<C-Space>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({ select = true, })
						end
					else
						fallback()
					end
				end),
				--

				-- ['<C-Space>'] = cmp.mapping(function(fallback) -- experimental
				-- 	if cmp.visible() then
				-- 		if luasnip.expandable() then
				-- 			luasnip.expand()
				-- 		else
				-- 			cmp.confirm({ select = true, })
				-- 		end
				-- 	else
				-- 		fallback()
				-- 	end
				-- end),

				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
						-- cmp.complete() -- generates a lot of slowdown; not sure what its for
					end
				end, {'i', 's'}),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					local cmp = require('cmp')
					local luasnip = require('luasnip')

					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- experimental
				-- ["<A-k>"] = cmp.mapping(
				-- 	function(fallback)
				-- 		local luasnip = require('luasnip')
				-- 		if luasnip.expand_or_jumpable() then
				-- 			luasnip.expand_or_jump()
				-- 		end
				-- 	end, { 'i', 's' }
				-- ),
				-- ["<A-j>"] = cmp.mapping(
				-- 	function()
				-- 		local luasnip = require('luasnip')
				-- 		if luasnip.jumpable(-1) then
				-- 			luasnip.jump(-1)
				-- 		end
				-- 	end, { 'i', 's' }
				-- )
				--
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			{
				{ name = 'buffer' },
			})
		})

		-- [IDEAS]
		-- * I could try making this a cmp mapping
		-- * Create a unstable branch for this config to avoided
		-- having to deal with this kind of problem at unoportune times
		--
		-- [unrelated]
		-- make a clipboard snippet

		vim.keymap.set('i', '<A- >', function()
			local cmp = require('cmp')
			if cmp.visible() then
				cmp.abort()
				return
			end

			vim.api.nvim_feedkeys("", "t", false)
		end, {noremap = true})


		-- Autopairs related
		-- local autopairs = require('nvim-autopairs.completion.cmp')
		-- 	autopairs.on_confirm_done(),
		-- cmp.event:on(
		-- 	"confirm_done",
		-- )



	end,
}
