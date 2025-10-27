return {
    'brianhuster/live-preview.nvim',
    dependencies = {
		'folke/snacks.nvim',
    },
	opts = {
		port = 4242,
		browser = 'default',
		dynamic_root = false,
		sync_scroll = true,
		picker = "snacks.picker"
	},
}
