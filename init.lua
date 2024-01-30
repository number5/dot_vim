vim.g.linterConfigFolder = vim.fn.stdpath "config" .. "linterConfigs"
-- bootstrap lazy.nvim, LazyVim and your plugins
require "config.lazy"
