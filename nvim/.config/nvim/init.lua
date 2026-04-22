-- =============================================================================
-- Neovim config — init.lua
-- =============================================================================

-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load options and keymaps
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins
require("lazy").setup("plugins", {
  rocks = { enabled = false },
  change_detection = { notify = false },
})
