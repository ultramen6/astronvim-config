local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

--------------------------------------------------------------------------------
-- Сниппеты для React / Next.js 14/15
-- Мы регистрируем их сразу для двух типов файлов:
-- "typescriptreact" (TSX) и "javascriptreact" (JSX).
--------------------------------------------------------------------------------
ls.add_snippets({ "typescriptreact", "javascriptreact" }, {

  -- 1. (BONUS)Interface Creation
  -- Trigger: inter
  s("hui", {
    t "interface Props {",
    t { "", "    " },
    i(1, "// props here"),
    t { "", "}" },
  }),
})
