local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

vim.g.mapleader = " "

require("bootstrap"):init(base_dir)

-- require("config"):load()

local plugins = require "plugins"
require("plugin-loader").load { plugins }

local Log = require "core.log"
Log:debug "Starting Palma Vim"

local modules = {
  "core.options",
  "core.mappings",
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    Log:error("Error loading " .. module .. "\n\n" .. err)
  end
end

-- non plugin mappings
-- require("core.mappings").misc()
