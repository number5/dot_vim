-- INFO: Server names are LSP names, not Mason names
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local lsp_servers = {
  "lua_ls",
  "yamlls",
  "jsonls",
  "cssls",
  "emmet_ls", -- css & html completion
  "pylsp", -- python
  "marksman", -- markdown
  "tsserver", -- ts/js
  "eslint", -- ts/js
  "bashls", -- also used for zsh
  "taplo", -- toml
}

--------------------------------------------------------------------------------

local lspSettings = {}
local lspFileTypes = {}

lspSettings.ruff_lsp = {}
-- https://github.com/LuaLS/lua-language-server/wiki/Annotations#annotations
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
lspSettings.lua_ls = {
  Lua = {
    format = { enable = false }, -- using stylua instead. Also, sumneko-lsp-formatting has this weird bug where all folds are opened
    workspace = { checkThirdParty = false },
    completion = {
      callSnippet = "Replace",
      keywordSnippet = "Replace",
      displayContext = 2,
      postfix = ".",
    },
    -- libraries defined per-project via luarc.json location: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
      disable = { "trailing-space" },
    },
    hint = {
      enable = true,
      setType = true,
      paramName = "All",
      paramType = true,
      arrayIndex = "Disable",
    },
    telemetry = { enable = false },
  },
}

-- https://github.com/sublimelsp/LSP-css/blob/master/LSP-css.sublime-settings
lspSettings.cssls = {
  css = {
    lint = {
      vendorPrefix = "ignore",
      propertyIgnoredDueToDisplay = "error",
      universalSelector = "ignore",
      float = "ignore",
      boxModel = "ignore",
      -- since these would be duplication with stylelint
      duplicateProperties = "ignore",
      emptyRules = "warning",
    },
    colorDecorators = { enable = true }, -- not supported yet
  },
}

-- https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
local jsAndTsSettings = {
  inlayHints = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all", -- none | literals | all
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  },
}

lspSettings.tsserver = {
  completions = { completeFunctionCalls = true },
  typescript = jsAndTsSettings,
  javascript = jsAndTsSettings,
  -- https://github.com/microsoft/TypeScript/blob/master/src/compiler/diagnosticMessages.json
  diagnostics = { ignoredCode = {} },
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
lspSettings.eslint = {
  quiet = false, -- = include warnings
  codeAction = {
    disableRuleComment = { location = "sameLine" }, -- add ignore-comments on the same line
  },
}

-- https://github.com/sublimelsp/LSP-json/blob/master/LSP-json.sublime-settings
lspSettings.jsonls = {
  json = {
    validate = { enable = true },
    format = { enable = true },
  },
}

-- https://github.com/redhat-developer/yaml-language-server#language-server-settings
lspSettings.yamlls = {
  yaml = { keyOrdering = false }, -- FIX mapKeyOrder
}

--------------------------------------------------------------------------------

lspFileTypes.bashls = { "sh", "zsh", "bash" } -- force lsp to work with zsh
lspFileTypes.emmet_ls = { "css", "scss", "html" }

--------------------------------------------------------------------------------

-- Enable snippet capability for completion (nvim_cmp)
local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable folding (nvim-ufo)
lspCapabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

--------------------------------------------------------------------------------

return {
  { -- package manager
    "williamboman/mason.nvim",
    lazy = true,
    dependencies = {
      -- Additional lua configuration. Setup defore setting up lspconfig for lua_ls.
      "folke/neodev.nvim",

      -- Hover guide for function signatures.
      "ray-x/lsp_signature.nvim",
    },
    opts = {
      diagnostics = {
        float = {
          source = "always",
        },
        virtual_text = false,
      },
    },

    config = function()
      require("mason").setup {
        ui = {
          border = BorderStyle,
          icons = {
            package_installed = "✓",
            package_pending = "羽",
            package_uninstalled = "✗",
          },
        },
      }
    end,
  },
  { -- auto-install lsp servers
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = lsp_servers,
      }
    end,
  },

  { -- configure LSPs
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim", -- lsp for nvim-lua config
    init = function()
      -- INFO plugin must be setup before lua lsp-config setup
      require("neodev").setup {
        library = { plugins = false },
      }

      -- LSP Server setup
      for _, lsp in pairs(lsp_servers) do
        local config = {
          capabilities = lspCapabilities,
          settings = lspSettings[lsp], -- if no settings, will assign nil and therefore to nothing
          filetypes = lspFileTypes[lsp],
        }
        require("lspconfig")[lsp].setup(config)
      end

      -- Border Styling
      require("lspconfig.ui.windows").default_options.border = BorderStyle
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = BorderStyle })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = BorderStyle })
    end,
    config = function(_, opts)
      local on_attach = function(client, bufnr)
        -- Attach the server to Navbuddy only if server is not ruff_lsp.
        -- ruff_lsp does not support documentSymbols.
        if client.name ~= "ruff_lsp" then
          require("nvim-navbuddy").attach(client, bufnr)
        end

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<C-c>", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
        -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
        nmap("<leader>bf", "<cmd>Format<CR>", "[B]uffer [F]ormat")
      end

      -- Add a border to the hover frame.
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      require("neodev").setup()

      vim.diagnostic.config(opts.diagnostics)

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require "mason-lspconfig"

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(opts.servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = opts.servers[server_name],
          }
        end,
      }

      -- Moved out of mason_lspconfig handlers loop because diagnostics
      -- were not being disabled.
      require("lspconfig").jedi_language_server.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          diagnostics = { enable = false },
        },
      }

      -- Workaround for warning when using clang-format (via null-ls) with clangd lsp.
      capabilities.offsetEncoding = { "utf-16" }

      require("lspconfig").clangd.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          diagnostics = { enable = false },
        },
      }
    end,
  },
}
