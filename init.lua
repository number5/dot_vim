vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Skip some remote provider loading
g.loaded_python_provider = 0
g.python3_host_prog = "/opt/homebrew/Caskroom/miniforge/base/bin/python"
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

-- require("config"):load()

local plugins = require "plugins"
require("plugin-loader").load { plugins }

local Log = require "core.log"
Log:debug "Starting Palma Vim"

local modules = {
  "config.global",
  "config.wk-mappings",
  "core.options",
  "core.mappings",
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    Log:error("Error loading " .. module .. "\n\n" .. err)
  end
end

-- vim.cmd "colorscheme nightfly"
vim.cmd "colorscheme kanagawa"
