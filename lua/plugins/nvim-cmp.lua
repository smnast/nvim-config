-- NOTE: Completion Engine
local luasnip = require "luasnip"
local cmp = require "cmp"
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  init = function()
    vim.keymap.set("n", "<leader>oa", function()
      vim.g.toggle_cmp = not vim.g.toggle_cmp
      if vim.g.toggle_cmp then
        vim.notify("Toggled On", vim.log.levels.INFO, { title = "Autocomplete" })
      else
        vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Autocomplete" })
      end
    end, { desc = "Options | Toggle Autocomplete" })
  end,
  opts = function()
    cmp.setup.cmdline(":", {
      sources = {
        { name = "cmdline" },
      },
    })
  end,
  config = function(_, opts)
    table.insert(opts.sources, 2, { name = "copilot" })
    table.insert(opts.sources, 3, { name = "nvim_lsp_signature_help" })
    opts.mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    }
    opts.window = {
      completion = {
        border = 'rounded',
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = 'rounded',
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      },
    }
    opts.enabled = function()
      return (vim.g.toggle_cmp and vim.bo.buftype == "")
    end

    luasnip.filetype_extend("javascriptreact", { "html" })
    luasnip.filetype_extend("typescriptreact", { "html" })
    luasnip.filetype_extend("svelte", { "html" })
    luasnip.filetype_extend("vue", { "html" })
    luasnip.filetype_extend("php", { "html" })

    opts.completion["completeopt"] = "menu,menuone,noselect" -- disable autoselect
    require("cmp").setup(opts)
  end,
  dependencies = {
    {
      "saecki/crates.nvim",
      tag = "v0.4.0",
      opts = {},
    },
    -- Commandline completions
    {
      "hrsh7th/cmp-cmdline",
    },
    -- AI Autocomplete
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      event = 'InsertEnter',
      opts = {
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
        }
      }
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function ()
        require("copilot_cmp").setup()
      end
    },
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
    },
    -- Display function signature
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
    }
  },
}
