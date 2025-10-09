
return {
	'hrsh7th/nvim-cmp',
	lazy = false,
	dependencies = {
		{ -- command mode autocomplete
			'hrsh7th/cmp-cmdline',
			commit = "d126061b624e0af6c3a556428712dd4d4194ec6d",
		},
		{ -- search mode autocomplete
			'hrsh7th/cmp-buffer',
			commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
		},
		{ -- this adds luasnip as a completion source for nvim.cmp
			"saadparwaiz1/cmp_luasnip",
			commit = '98d9cb5c2c38532bd9bdb481067b20fea8f32e90'
		},
		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
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
				-- { name = 'buffer' },
			},
			{
				{ name = 'buffer' },
			})
		})

		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			},
			view = {entries = {
				name = 'wildmenu',
				separator = "  ",
			}}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
			view = {entries = {
				name = 'wildmenu',
				separator = "  ",
			}}
		})

		vim.keymap.set('i', '<A- >', function()
			local cmp = require('cmp')
			if cmp.visible() then
				cmp.abort()
				return
			end

			vim.api.nvim_feedkeys("", "t", false)
		end, {noremap = true})

	end,
}
