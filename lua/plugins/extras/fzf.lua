return {
  -- Disable telescope
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  -- Setup fzf-lua
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      hls = {
        border = "FloatBorder",
        cursorline = "Visual",
        cursorlinenr = "Visual",
      },
      -- History file
      fzf_opts = {
        ["--history"] = vim.fn.stdpath "data" .. "/fzf-lua-history",
        ["--info"] = false,
        ["--border"] = false,
        ["--preview-window"] = false,
      },
      files = {
        multiprocess = true,
      },
      grep = {
        multiprocess = true,
      },
      git = {
        files = {
          multiprocess = true,
        },
        status = {
          winopts = {
            preview = { vertical = "down:70%", horizontal = "right:70%" },
          },
        },
        commits = { winopts = { preview = { vertical = "down:60%" } } },
        bcommits = { winopts = { preview = { vertical = "down:60%" } } },
        branches = {
          winopts = {
            preview = { vertical = "down:75%", horizontal = "right:75%" },
          },
        },
      },
      lsp = {
        async_or_timeout = true,
        symbols = {
          path_shorten = 1,
        },
        code_actions = {
          winopts = {
            preview = { layout = "reverse-list", horizontal = "right:75%" },
          },
        },
      },
    },
    config = function(_, options)
      local fzf_lua = require "fzf-lua"

      -- Refer https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua#L69 for default keymaps
      -- Shift+up/down to move the preview window
      -- Alt+q to send to quickfix
      -- Alt+a to toggle all
      -- fzf_lua.setup(options)
      fzf_lua.setup("fzf-native", options)

      -- Automatic sizing of height/width of vim.ui.select
      fzf_lua.register_ui_select(function(_, items)
        local min_h, max_h = 0.60, 0.80
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.80, row = 0.40 } }
      end)

      -- Refer https://github.com/ibhagwan/fzf-lua/issues/602
      vim.lsp.handlers["textDocument/codeAction"] = fzf_lua.lsp_code_actions
      vim.lsp.handlers["textDocument/definition"] = fzf_lua.lsp_definitions
      vim.lsp.handlers["textDocument/declaration"] = fzf_lua.lsp_declarations
      vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lua.lsp_typedefs
      vim.lsp.handlers["textDocument/implementation"] = fzf_lua.lsp_implementations
      vim.lsp.handlers["textDocument/references"] = fzf_lua.lsp_references
      vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lua.lsp_document_symbols
      vim.lsp.handlers["workspace/symbol"] = fzf_lua.lsp_workspace_symbols
      vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lua.lsp_incoming_calls
      vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lua.lsp_outgoing_calls
    end,
    keys = {
      -- Find file by grep
      {
        "<C-g>",
        "<cmd> :FzfLua grep_project<CR>",
        desc = "Find Grep",
      },
      {
        "<C-g>",
        function()
          -- Grep visual selection in the current directory or lsp root or git root
          local root_dir = require("lazyvim.util").root()
          local fzf_lua = require "fzf-lua"
          fzf_lua.setup {
            grep = {
              -- use `ctrl-r` to not override the `ctrl-g` regex toggle
              actions = { ["ctrl-r"] = { fzf_lua.actions.toggle_ignore } },
            },
          }

          fzf_lua.grep_visual {
            cwd = root_dir,
            rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
            multiprocess = true,
          }
        end,
        desc = "Search Grep in visual selection",
        mode = "v",
      },
      {
        "<leader>sw",
        function()
          -- Grep visual selection in the current directory or lsp root or git root
          local root_dir = require("lazyvim.util").root.git()
          local fzf_lua = require "fzf-lua"
          fzf_lua.setup {
            grep = {
              -- use `ctrl-r` to not override the `ctrl-g` regex toggle
              actions = { ["ctrl-r"] = { fzf_lua.actions.toggle_ignore } },
            },
          }

          fzf_lua.grep_visual {
            cwd = root_dir,
            rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
            multiprocess = true,
          }
        end,
        desc = "Search word in visual selection (git root)",
        mode = "v",
      },
      {
        "<leader>fg",
        "<cmd> :FzfLua grep_project --cmd 'git grep --line-number --column --color=always'<CR>",
        desc = "Find Git Grep",
      },
      -- Find open buffers
      {
        "<leader>,",
        "<cmd> :FzfLua buffers<CR>",
        desc = "Find Buffers",
      },
      -- Find recent files
      {
        "<leader>fr",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").oldfiles { cwd = root_dir }
        end,
        desc = "Find Recent Files",
      },
      -- Resume last fzf command
      {
        "<leader>fR",
        "<cmd> :FzfLua resume<CR>",
        desc = "Resume Fzf",
      },
      -- File file by live grep, better for large projects
      {
        "<leader>fl",
        function()
          local root_dir = require("lazyvim.util").root.git()
          local fzf_lua = require "fzf-lua"
          fzf_lua.setup {
            grep = {
              -- use `ctrl-r` to not override the `ctrl-g` regex toggle
              actions = { ["ctrl-r"] = { fzf_lua.actions.toggle_ignore } },
            },
          }
          fzf_lua.live_grep {
            cwd = root_dir,
            rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
            multiprocess = true,
          }
        end,
        desc = "Find Live Grep (including hidden files)",
      },
      -- Find files at the current working directory
      {
        "<leader><space>",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").files {
            cwd = root_dir,
            cwd_prompt = false,
          }
        end,
        desc = "Find Files at project directory",
      },
      {
        "<C-e>",
        function()
          local root_dir = require("lazyvim.util").root()
          require("fzf-lua").files {
            cwd = root_dir,
            cwd_prompt = false,
          }
        end,
        desc = "Find Files at project directory",
      },
      -- File files by live grep in the current directory or LSP root or git root
      {
        "<leader>/",
        function()
          -- Live grep in the current directory or LSP root or git root
          local root_dir = require("lazyvim.util").root()
          require("fzf-lua").live_grep { cwd = root_dir, multiprocess = true }
        end,
        desc = "Grep Files at current directory",
      },
      -- Find file in git
      {
        "<leader>ff",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").git_files { cwd = root_dir }
        end,
        desc = "Find Git Files",
      },
      -- Find nvim config file
      {
        "<leader>fc",
        function()
          require("fzf-lua").files { cwd = "~/.config/nvim" }
        end,
        desc = "Find Neovim Configs",
      },

      -- Search in current buffer with grep
      {
        "<leader>sb",
        "<cmd> :FzfLua grep_curbuf<CR>",
        desc = "Search Current Buffer",
      },
      {
        "<leader>sB",
        "<cmd> :FzfLua lines<CR>",
        desc = "Search Lines in Open Buffers",
      },
      {
        "<leader>sw",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").grep_cword { cwd = root_dir, multiprocess = true }
        end,
        desc = "Search word under cursor (git root)",
      },
      {
        "<leader>sW",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").grep_cWORD { cwd = root_dir, multiprocess = true }
        end,
        desc = "Search WORD under cursor (git root)",
      },

      -- Git related keymaps
      -- Search in git status
      {
        "<leader>gs",
        function()
          local root_dir = require("lazyvim.util").root.git()
          require("fzf-lua").git_status { cwd = root_dir }
        end,
        desc = "Git Status",
      },
      {
        "<leader>gc",
        "<cmd> :FzfLua git_commits<CR>",
        desc = "Git Commits",
      },
      {
        "<leader>gb",
        "<cmd> :FzfLua git_branches<CR>",
        desc = "Git Branches",
      },
      {
        "<leader>gB",
        "<cmd> :FzfLua git_bcommits<CR>",
        desc = "Git Buffer Commits",
      },

      -- Search keymaps
      {
        "<leader>sa",
        "<cmd> :FzfLua commands<CR>",
        desc = "Find Actions",
      },
      {
        "<leader>s:",
        "<cmd> :FzfLua command_history<CR>",
        desc = "Find Command History",
      },
      {
        "<leader>ss",
        "<cmd> :FzfLua lsp_document_symbols<CR>",
        desc = "LSP Document Symbols",
      },
      {
        "<leader>sS",
        "<cmd> :FzfLua lsp_workspace_symbols<CR>",
        desc = "LSP Workspace Symbols",
      },
      {
        "<leader>si",
        "<cmd> :FzfLua lsp_incoming_calls<CR>",
        desc = "LSP Incoming Calls",
      },
      {
        "<leader>so",
        "<cmd> :FzfLua lsp_outgoing_calls<CR>",
        desc = "LSP Outgoing Calls",
      },
      {
        "<leader>sk",
        "<cmd> :FzfLua keymaps<CR>",
        desc = "Search Keymaps",
      },
      {
        "<leader>sm",
        "<cmd> :FzfLua marks<CR>",
        desc = "Search Marks",
      },
      {
        "<leader>st",
        "<cmd> :FzfLua tmux_buffers<CR>",
        desc = "Search Tmux buffers",
      },
      {
        "<leader>sc",
        "<cmd> :FzfLua colorschemes<CR>",
        desc = "Search colorschemes",
      },
      {
        "<leader>sh",
        "<cmd> :FzfLua help_tags<CR>",
        desc = "Search Help",
      },
      {
        "<leader>sq",
        "<cmd> :FzfLua quickfix<CR>",
        desc = "Search Quickfix",
      },

      -- Switch project
      -- Find in recent projects
      {
        "<leader>fp",
        function()
          local fzf_lua = require "fzf-lua"

          local ok, _ = pcall(require, "project_nvim")
          if not ok then
            vim.notify("Project.nvim is not installed", vim.log.levels.ERROR, { title = "Fzf Lua" })
            return
          end

          local history = require "project_nvim.utils.history"
          local results = history.get_recent_projects()
          fzf_lua.fzf_exec(results, {
            actions = {
              ["default"] = {
                function(selected)
                  fzf_lua.files { cwd = selected[1] }
                end,
              },
            },
          })
        end,
        desc = "Search Recent Projects",
      },
    },
  },
  -- Setup LSP for fzf-lua
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change keymap to use FzfLua
      keys[#keys + 1] = {
        "gr",
        "<cmd> FzfLua lsp_references async=true<CR>",
        desc = "Go to references",
      }
      keys[#keys + 1] = { "gd", "<cmd> FzfLua lsp_definitions async=true<CR>", desc = "Go to definition" }
      keys[#keys + 1] = { "gD", "<cmd> FzfLua lsp_declarations async=true<CR>", desc = "Go to declaration" }
      keys[#keys + 1] = { "gI", "<cmd> FzfLua lsp_implementations async=true<CR>", desc = "Go to implementation" }
      keys[#keys + 1] = { "gT", "<cmd> FzfLua lsp_typedefs async=true<CR>", desc = "Go to type definition" }
      keys[#keys + 1] = { "gF", "<cmd> FzfLua lsp_finder async=true<CR>", desc = "LSP Finder" }
    end,
  },
}
