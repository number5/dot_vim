-- Plugins
local plugins = {
	-- Package manager
  { "wbthomason/packer.nvim" },

	-- LSP
	{
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
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
			"kosayoda/nvim-lightbulb",
			"weilbith/nvim-code-action-menu",
		},
		config = function()
		 -- require("config.lsp")
		 -- require("config.lsp_cmp")
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]])
		end,
	},

	-- Linting and formatting
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		-- config = function()
			-- require("configs.null-ls")
		-- end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"p00f/nvim-ts-rainbow",
			"RRethy/nvim-treesitter-textsubjects",
		},
		run = ":TSUpdate",
		-- config = function()
			-- require("config.treesitter")
		-- end,
	},

	-- Debugging
	-- use 'mfussenegger/nvim-dap'
	-- use 'rcarriga/nvim-dap-ui'
	-- use 'Pocco81/DAPInstall.nvim'

	-- Quality of life enhancements
	{
		-- Use 'CTRL + /' to comment line or selection
		"b3nj5m1n/kommentary",
		config = function()
			vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {})
			vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default<C-c>", {})
		end,
	},
	{
		-- Manipulate parentheses, brackets etc
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	},
	{
		-- Auto close brackets etc (with treesitter support)
		"windwp/nvim-autopairs",
		after = { "nvim-cmp" },
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			require("nvim-autopairs").setup({ check_ts = true })
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.api.nvim_set_option("timeoutlen", 300)
			require("which-key").setup({})
		end,
	},

	-- Looks
	{
		-- Startpage
		"glepnir/dashboard-nvim",
		requires = "nvim-telescope/telescope.nvim",
		config = function()
			-- require("config.dashboard")
		end,
	},
	{
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
	},
	{
		-- Draw indentation lines (highlighting based on treesitter)
		"lukas-reineke/indent-blankline.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			-- require("config.blankline")
		end,
	},
	{
		-- Color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Telescope (Fuzzy finding)
	{
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		-- config = function()
			-- require("config.telescope")
		-- end,
	},

	-- Git
  { "airblade/vim-gitgutter", }
}

return plugins
