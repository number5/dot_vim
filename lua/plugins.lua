-- Bootstrap packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

vim.api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
	false
)

-- Plugin specification
return require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- LSP
	use({
		-- Autocomplete
		"hrsh7th/nvim-cmp",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-lua/lsp-status.nvim",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/lsp_signature.nvim",
			"williamboman/nvim-lsp-installer",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
			"kosayoda/nvim-lightbulb",
			"weilbith/nvim-code-action-menu",
		},
		config = function()
			require("config.lsp")
			require("config.lsp_cmp")
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]])
		end,
	})
	-- use 'nvim-lua/lsp_extensions.nvim'

	-- Linting and formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		config = function()
			require("config.language")
		end,
	})

	-- File manager
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
			require("nvim-tree").setup({
				auto_close = true,
				update_focused_file = {
					enable = true,
				},
				view = {
					width = 40,
				},
			})
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"p00f/nvim-ts-rainbow",
			"RRethy/nvim-treesitter-textsubjects",
		},
		run = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	})

	-- Debugging
	-- use 'mfussenegger/nvim-dap'
	-- use 'rcarriga/nvim-dap-ui'
	-- use 'Pocco81/DAPInstall.nvim'

	-- Quality of life enhancements
	use({
		-- Use 'CTRL + /' to comment line or selection
		"b3nj5m1n/kommentary",
		config = function()
			vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {})
			vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default<C-c>", {})
		end,
	})
	use({
		-- Manipulate parentheses, brackets etc
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	})
	use({
		-- Auto close brackets etc (with treesitter support)
		"windwp/nvim-autopairs",
		after = { "nvim-cmp" },
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			require("nvim-autopairs").setup({ check_ts = true })
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
		end,
	})
	use({
		"folke/which-key.nvim",
		config = function()
			vim.api.nvim_set_option("timeoutlen", 300)
			require("which-key").setup({})
		end,
	})

	-- Looks
	use({
		-- Startpage
		"glepnir/dashboard-nvim",
		requires = "nvim-telescope/telescope.nvim",
		config = function()
			require("config.dashboard")
		end,
	})
	use({
		-- Color theme
		"mhartington/oceanic-next",
		config = function()
			vim.cmd("colorscheme OceanicNext")
			-- Fix transparent background
			vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
			vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
			vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
			vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
		end,
	})
	use({
		-- Draw indentation lines (highlighting based on treesitter)
		"lukas-reineke/indent-blankline.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("config.blankline")
		end,
	})
	use({
		-- Status line
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "nvim-lua/lsp-status.nvim" },
		config = function()
			require("lualine").setup({
				options = { theme = "OceanicNext" },
				sections = {
					lualine_x = { require("lsp-status").status, "encoding", "fileformat", "filetype" },
				},
			})
		end,
	})
	use({
		-- Color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Telescope (Fuzzy finding)
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("config.telescope")
		end,
	})

	-- Git
	use("airblade/vim-gitgutter")
end)
