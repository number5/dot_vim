return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "lukas-reineke/cmp-rg",
    "lukas-reineke/cmp-under-comparator",
    "petertriho/cmp-git",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require "cmp"
    local cmdline_mappings = {
      select_next_item = {
        c = function(fallback)
          if cmp.visible() then
            return cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }(fallback)
          else
            return cmp.mapping.complete { reason = cmp.ContextReason.Auto }(fallback)
          end
        end,
      },
      select_prev_item = {
        c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      },
    }

    cmp.setup.cmdline(":", {
      mapping = {
        ["<C-n>"] = cmdline_mappings.select_next_item,
        ["<Down>"] = cmdline_mappings.select_next_item,
        ["<C-p>"] = cmdline_mappings.select_prev_item,
        ["<Up>"] = cmdline_mappings.select_prev_item,
      },
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }, {
        { name = "buffer" },
      }, {
        { name = "cmdline_history" },
      }),
    })
    cmp.setup.cmdline("/", {
      mapping = {
        ["<C-n>"] = cmdline_mappings.select_next_item,
        ["<Down>"] = cmdline_mappings.select_next_item,
        ["<C-p>"] = cmdline_mappings.select_prev_item,
        ["<Up>"] = cmdline_mappings.select_prev_item,
      },
      sources = cmp.config.sources({
        { name = "buffer" },
      }, {
        { name = "cmdline_history" },
      }),
    })

    return {
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-5),
        ["<C-f>"] = cmp.mapping.scroll_docs(5),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = function(fallback)
          if cmp.visible() then
            return cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }(fallback)
          else
            return fallback()
          end
        end,

        ["<C-n>"] = function(fallback)
          if cmp.visible() then
            return cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }(fallback)
          else
            return cmp.mapping.complete { reason = cmp.ContextReason.Auto }(fallback)
          end
        end,
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      },

      sorting = {
        priority_weight = 100,
        comparators = {
          cmp.config.compare.recently_used,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      sources = {
        { name = "path", priority_weight = 110 },
        { name = "git", priority_weight = 110 },
        { name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
        { name = "cmp_yanky", max_item_count = 5, priority_weight = 100 },
        { name = "emoji", max_item_count = 5, priority_weight = 95 },
        { name = "nvim_lua", priority_weight = 90 },
        { name = "buffer", max_item_count = 5, priority_weight = 70 },
        { name = "nvim_lsp_signature_help" },
        { name = "snippets", max_item_count = 5, priority_weight = 70 },
        {
          name = "rg",
          keyword_length = 5,
          max_item_count = 5,
          priority_weight = 40,
          option = {
            additional_arguments = "--smart-case --hidden",
          },
        },
      },

      formatting = {
        format = function(entry, vim_item)
          local icons = require("lazyvim.config").icons.kinds
          local dev_icons = require "nvim-web-devicons"
          local menu_map = {
            gh_issues = "[Issues]",
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[API]",
            path = "[Path]",
            -- look = "[Look]",
            rg = "[RG]",
            -- cmp_jira = "[JIRA]",
          }
          vim_item.menu = menu_map[entry.source.name] or string.format("[%s]", entry.source.name)

          if vim_item.kind == "File" then
            vim_item.kind = dev_icons.get_icon(vim_item.word, nil, { default = true }) .. " [file]"
          else
            if icons[vim_item.kind] then
              vim_item.kind = icons[vim_item.kind] .. vim_item.kind
            end
          end

          return vim_item
        end,
      },

      window = {
        documentation = {
          border = vim.g.floating_window_border_dark,
        },
        completion = {
          border = vim.g.floating_window_border_dark,
        },
      },
    }
  end,
}
