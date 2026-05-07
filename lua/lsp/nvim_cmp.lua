
return {
	'hrsh7th/nvim-cmp',

	-- lazy loading nvim-cmp may cause some weird problems
	-- if autocomplete and snippets aren't working for any apparent
	-- reason, delete those lines

	event = {"InsertEnter", "CmdlineEnter"},
	-- lazy = false,

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
		local cmp     = require('cmp')
		local luasnip = require('luasnip')

		km('n', '<A-n>', function ()
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			end
		end)
		km('n', '<A-N>', function ()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end)

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
				['<C-j>'] = cmp.mapping.scroll_docs(-4),
				['<C-k>'] = cmp.mapping.scroll_docs(4),


				-- default autocomplete selection commands
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-e>'] = cmp.mapping.abort(),

				['<CR>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						elseif cmp.get_selected_entry() then
							cmp.confirm({ select = false })
						else
							fallback()
						end
					else
						fallback()
					end
					-- if luasnip.choice_active() then
					-- 	require("luasnip.extras.select_choice")()
					-- end
				end),

				-- TODO: add a autocommand to delete luasnip's history stack
				-- after exiting insert mode
				["<A-n>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					end
				end),
				["<A-N>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					end
				end),

				["<C-Space>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
						return
					end
				end),

				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- elseif luasnip.locally_jumpable(1) then
						-- 	luasnip.jump(1)
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
				-- not sure about the mappings yet
				['<A-j>'] = cmp.mapping(function(fallback)

					if luasnip.choice_active() then
						require("luasnip.extras.select_choice")()
						return
					end
					fallback()

				end, {"i", "s"}),

				['<A-m>'] = cmp.mapping(function(fallback)
					if require("luasnip").choice_active() then
						require("luasnip").change_choice(1)
						return
					end
					fallback()
				end, {"i", "s"}),

				['<A-M>'] = cmp.mapping(function(fallback)
					if require("luasnip").choice_active() then
						require("luasnip").change_choice(-1)
						return
					end
					fallback()
				end, {"i", "s"})

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

	end,
}
