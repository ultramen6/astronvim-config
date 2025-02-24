-- user.lua (или plugins.lua - главное, чтобы Lazy знал об этом файле)
return {
  -- Пример плагина presence.nvim
  "andweeb/presence.nvim",

  -- Пример плагина lsp_signature
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- Отключаем better-escape
  { "max397574/better-escape.nvim", enabled = false },

  -- Подключаем и настраиваем LuaSnip (AstroNvim-стиль)

  -- Пример nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      -- В AstroNvim: базовый конфиг
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)

      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      npairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
          :with_pair(cond.not_after_regex "%%")
          :with_pair(cond.not_before_regex("xxx", 3))
          :with_move(cond.none())
          :with_del(cond.not_after_regex "xx")
          :with_cr(cond.none()),
      }, Rule("a", "a", "-vim"))
    end,
  },

  -- Настраиваем nvim-cmp, чтобы работало с LuaSnip
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      cmp.setup {
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping.confirm { select = true },
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        },
        sources = cmp.config.sources {
          { name = "luasnip" }, -- LuaSnip должен быть на первом месте
          { name = "nvim_lsp" }, -- другие источники, если нужно
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    -- Заставляем Lazy установить зависимости
    build = function()
      -- Эта команда скачивает и устанавливает зависимость для превью (mdenv/пакет nodejs)
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" }, -- плагин загружается только при открытии Markdown-файлов
    config = function()
      -- Ваши настройки (можно оставить пустым, если дефолт ок)
      vim.g.mkdp_auto_start = 0 -- не запускать предпросмотр автоматически
      vim.g.mkdp_auto_close = 1 -- автоматически закрывать при выходе из буфера
      vim.g.mkdp_refresh_slow = 0 -- обновлять предпросмотр при каждом сохранении
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_filetypes = { "markdown" }

      -- Если хотите, чтобы окно предпросмотра открылось в браузере:
      -- vim.g.mkdp_browser = "google-chrome"

      -- Можно назначить хоткей для запуска предпросмотра, например <leader>mp
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mp",
        "<cmd>MarkdownPreview<CR>",
        { noremap = true, silent = true, desc = "Markdown Preview" }
      )
    end,
  },
}
