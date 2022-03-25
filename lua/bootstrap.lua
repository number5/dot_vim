local M = {}

if vim.fn.has "nvim-0.6.1" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Lunarvim requires v0.6.1+", vim.log.levels.WARN)
  vim.wait(5000, function()
    return false
  end)
  vim.cmd "cquit"
end

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
local in_headless = #vim.api.nvim_list_uis() == 0

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

---Require a module in protected mode without relying on its cached value
---@param module string
---@return any
function _G.require_clean(module)
  package.loaded[module] = nil
  _G[module] = nil
  local _, requested = pcall(require, module)
  return requested
end

---Get the full path to `$LUNARVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
  local lvim_runtime_dir = os.getenv "LUNARVIM_RUNTIME_DIR"
  if not lvim_runtime_dir then
    -- when nvim is used directly
    return vim.fn.stdpath "data"
  end
  return lvim_runtime_dir
end

---Get the full path to `$LUNARVIM_CONFIG_DIR`
---@return string
function _G.get_config_dir()
  local lvim_config_dir = os.getenv "LUNARVIM_CONFIG_DIR"
  if not lvim_config_dir then
    return vim.fn.stdpath "config"
  end
  return lvim_config_dir
end

---Get the full path to `$LUNARVIM_CACHE_DIR`
---@return string
function _G.get_cache_dir()
  local lvim_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not lvim_cache_dir then
    return vim.fn.stdpath "cache"
  end
  return lvim_cache_dir
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
  self.runtime_dir = base_dir
  self.config_dir = base_dir
  self.cache_dir = join_paths(base_dir, "cache")
  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  self.packer_cache_path = join_paths(self.runtime_dir, "plugin", "packer_compiled.lua")

  ---Get the full path to base directory
  ---@return string
  function _G.get_base_dir()
    return base_dir
  end

  vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site"))
  vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site", "after"))
  vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
  vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

  vim.opt.rtp:remove(vim.fn.stdpath "config")
  vim.opt.rtp:remove(join_paths(vim.fn.stdpath "config", "after"))
  vim.opt.rtp:prepend(self.config_dir)
  vim.opt.rtp:append(join_paths(self.config_dir, "after"))
  -- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp

  vim.cmd [[let &packpath = &runtimepath]]

  -- FIXME: currently unreliable in unit-tests
  if not in_headless then
    _G.PLENARY_DEBUG = false
  end

  -- require("config"):init()

  require("plugin-loader").init {
    package_root = self.pack_dir,
    install_path = self.packer_install_dir,
  }

  return self
end

return M
