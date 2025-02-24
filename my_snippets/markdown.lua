local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
  s("de", {
    t { "<details>", "", "" },
    i(1),
    t { "", "", "</details>", "", "" },
  }),
  s("dety", {
    t { "<details>", "", "```typescript", "" },
    i(1),
    t { "", "```", "</details>", "", "---", "" },
  }),
  s("de-", {
    t { "<details>", "", "" },
    i(1),
    t { "", "", "</details>", "", "---", "" },
  }),
})
