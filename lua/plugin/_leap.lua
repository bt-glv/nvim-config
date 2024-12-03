
-- TODO: this can be lazy loaded
return {
  'ggandor/leap.nvim',
  lazy = false,
  dependencies = {'tpope/vim-repeat', 'tpope/vim-surround' },
  -- surround is a dependency because its config file must run first and define the plugin's keys. Otherwise leap remaps will be overwritten.
  config = function()
	require('leap').create_default_mappings()
	km("v","s", "<Plug>(leap-forward)")
	km("v","S", "<Plug>(leap-backward)")
	-- Surround is using <leader>s 
  end
}
