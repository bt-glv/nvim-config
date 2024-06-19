
-- TODO: this can be lazy loaded
local config = {
  'ggandor/leap.nvim',
  lazy = false,
  dependencies = {"tpope/vim-repeat"},
  config = function()
	require('leap').create_default_mappings()
	kmv("s", "<Plug>(leap-forward)")
	kmv("S", "<Plug>(leap-backward)")
	-- Surround is using <leader>s 
  end
}
Lazy_plugin_add(config)

