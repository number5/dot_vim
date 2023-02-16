-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
local g = vim.g

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Skip some remote provider loading
g.loaded_python_provider = 0
g.python3_host_prog = "/Users/bruce.wang/.asdf/installs/python/3.10.10/bin/python"
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "gzip",
  "man",
  "matchit",
  "matchparen",
  "shada_plugin",
  "tarPlugin",
  "tar",
  "zipPlugin",
  "zip",
  "netrwPlugin",
}

for i = 1, 10 do
  g["loaded_" .. disabled_built_ins[i]] = 1
end

local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end
require("bootstrap"):init(base_dir)

-- bootstrap lazy.nvim 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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



-- require("config"):load()


local Log = require "core.log"

local modules = {
  "core.options",
  "core.mappings",
  "config.settings",
  "config.wk-mappings",
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    Log:error("Error loading " .. module .. "\n\n" .. err)
  end
end

require("lazy").setup("plugins")

-- vim.cmd "colorscheme nightfly"
-- vim.cmd "colorscheme kanagawa"
-- vim.cmd "colorscheme tokyonight-night"
vim.cmd "colorscheme moonbow"
