-- https://github.com/rachartier/tiny-glimmer.nvim
local tiny_glimmer_ok, tiny_glimmer = pcall(require, "tiny-glimmer")
if tiny_glimmer_ok then
    tiny_glimmer.setup({
        animations = {
            fade = {
                from_color = "#f0e056",
                to_color = "#00e05f",
            },
        },
        overwrite = {
            yank = { enabled = true, default_animation = "fade" },
            paste = { enabled = true, default_animation = "fade" },
        },
    })
end
