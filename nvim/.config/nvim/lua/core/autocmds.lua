local autocmd = vim.api.nvim_create_autocmd

-- Enable TreeSitter when a buffer is open
autocmd({"BufReadPost", "BufNewFile"}, {
	callback = function()
		vim.schedule(function()
			vim.cmd("TSBufEnable highlight")
		end)
	end,
})

-- Enable TreeSitter for .tpp files 
autocmd('Filetype', {
  pattern = { 'tpp' },
  command = 'set filetype=cpp'
})

autocmd('BufNewFile', {
  pattern = { '*.c', '*.h', '*.py' },
  command = 'Stdheader',
})
