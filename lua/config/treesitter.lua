local remap = vim.api.nvim_set_keymap

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "python",
    "javascript",
    "typescript",
    "fennel",
    "clojure",
    "go",
    "ruby",
    "bash",
    "yaml",
    "json",
  },
  indent = { enable = true },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  autopairs = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["as"] = "@statement.outer",
        -- ["is"] = "@scopename.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ak"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>l"] = "@parameter.inner",
        ["<leader>j"] = "@statement.outer",
      },
      swap_previous = {
        ["<leader>h"] = "@parameter.inner",
        ["<leader>k"] = "@statement.outer",
      },
    },
    --[[ move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
		}, ]]
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
}

-- remap('n', ']]', '<cmd>TSTextobjectGotoNextStart @class.outer<cr>zz', {})
-- remap('n', '][', '<cmd>TSTextobjectGotoNextEnd @class.outer<cr>zz', {})
-- remap('n', '[[', '<cmd>TSTextobjectGotoPreviousStart @class.outer<cr>zz', {})
-- remap('n', '[]', '<cmd>TSTextobjectGotoPreviousEnd @class.outer<cr>zz', {})
-- remap('n', ']m', '<cmd>TSTextobjectGotoNextStart @function.outer<cr>zz', {})
-- remap('n', ']M', '<cmd>TSTextobjectGotoNextEnd @function.outer<cr>zz', {})
-- remap('n', '[m', '<cmd>TSTextobjectGotoPreviousStart @function.outer<cr>zz', {})
-- remap('n', '[M', '<cmd>TSTextobjectGotoPreviousEnd @function.outer<cr>zz', {})
remap("n", "(", "<cmd>TSTextobjectGotoPreviousStart @block.outer<cr>zz", {})
remap("n", ")", "<cmd>TSTextobjectGotoNextStart @block.outer<cr>zz", {})
