-- Bootstrap Lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Run setup, load mods
require("lazy").setup({
    {
        import = "mods.ui"
    },
    {
        import = "mods.navigation"
    },
    {
        import = "mods.motion"
    },
    {
        import = "mods.language"
    },
    {
        import = "mods.coding"
    },
    {
        import = "mods.utils"
    },
})
