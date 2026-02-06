-- https://github.com/nvim-treesitter/nvim-treesitter

--local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
--if treesitter_ok then
--	treesitter.setup({
--	  ensure_installed = { "python" },
--	  auto_install = true,
--	})
--end

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "python" },
}


-- local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
-- if treesitter_ok then

    -- treesitter.setup({
    --     install_dir = vim.fn.stdpath('data') .. '/site'
    -- })
    -- treesitter.install({ 'python' })
-- end
