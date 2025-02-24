return {
  "L3MON4D3/LuaSnip",
  version = "2.*", -- или tag = "v2.*"
  config = function(plugin, opts)
    -- Загружаем базовую конфигурацию AstroNvim для LuaSnip
    require "astronvim.plugins.configs.luasnip"(plugin, opts)

    local luasnip = require "luasnip"
    -- Расширяем filetype, чтобы сниппеты для javascriptreact и typescriptreact работали
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("typescript", { "typescriptreact" })

    -- Загружаем свои сниппеты из каталога
    require("luasnip.loaders.from_lua").load {
      paths = { vim.fn.expand "~/.config/nvim/lua/my_snippets" },
    }
  end,
}
