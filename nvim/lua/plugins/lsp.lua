return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "angularls",
        "tsserver",
        "tailwindcss",
        "pyright",
        "nginx_language_server",
        "jsonls",
        "html",
        "graphql",
        "emmet_language_server",
        "dockerls",
        "cssls",
      },
      handlers = {
        function(server_name)
          if server_name == "remark_ls" then return end
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["angularls"] = function()
          local lspconfig = require("lspconfig")
          local default_node_modules = vim.fn.getcwd() .. "/node_modules"

          local ngls_cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            default_node_modules,
            "--ngProbeLocations",
            default_node_modules,
            "--experimental-ivy",
          }

          lspconfig.angularls.setup({
            cmd = ngls_cmd,
            on_new_config = function(new_config)
              new_config.cmd = ngls_cmd
            end,
          })
        end
      }
    })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["angularls"] = function()
          local lspconfig = require("lspconfig")
          local default_node_modules = vim.fn.getcwd() .. "/node_modules"

          local ngls_cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            default_node_modules,
            "--ngProbeLocations",
            default_node_modules,
            "--experimental-ivy",
          }

          lspconfig.angularls.setup({
            cmd = ngls_cmd,
            on_new_config = function(new_config)
              new_config.cmd = ngls_cmd
            end,
          })
        end
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      enabled = function()
        return not vim.api.nvim_buf_get_option(0, 'filetype'):match('markdown')
      end,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
