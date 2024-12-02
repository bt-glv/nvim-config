
return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	lazy = false,
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		kmn("<leader>ha", function() harpoon:list():add() end)
		kmn("<leader>hs", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
			-- sometimes, this function also needs for another movement to register for the harpoon interface to show up
			vim.api.nvim_feedkeys("k", "t", false)
		end)

		kmn("<leader>1", function() harpoon:list():select(1) end)
		kmn("<leader>2", function() harpoon:list():select(2) end)
		kmn("<leader>3", function() harpoon:list():select(3) end)
		kmn("<leader>4", function() harpoon:list():select(4) end)
		kmn("<leader>5", function() harpoon:list():select(5) end)
		kmn("<leader>6", function() harpoon:list():select(6) end)
		kmn("<leader>7", function() harpoon:list():select(7) end)
		kmn("<leader>8", function() harpoon:list():select(8) end)
		kmn("<leader>9", function() harpoon:list():select(9) end)
		kmn("<A-1>", function() harpoon:list():select(1) end)
		kmn("<A-2>", function() harpoon:list():select(2) end)
		kmn("<A-3>", function() harpoon:list():select(3) end)
		kmn("<A-4>", function() harpoon:list():select(4) end)
		kmn("<A-5>", function() harpoon:list():select(5) end)
		kmn("<A-6>", function() harpoon:list():select(6) end)
		kmn("<A-7>", function() harpoon:list():select(7) end)
		kmn("<A-8>", function() harpoon:list():select(8) end)
		kmn("<A-9>", function() harpoon:list():select(9) end)

		-- Toggle previous & next buffers stored within Harpoon list
		kmn("<leader>N", function() harpoon:list():prev() end)
		kmn("<leader>n", function() harpoon:list():next() end)

	end -- END Config function
}
