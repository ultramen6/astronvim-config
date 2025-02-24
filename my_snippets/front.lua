local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Если хотите автоматически подставлять имя файла вместо ${TM_FILENAME_BASE}
local function filename_base()
  return vim.fn.expand "%:t:r" -- %:t:r = имя файла без расширения
end

--------------------------------------------------------------------------------
-- Сниппеты для React / Next.js 14/15
-- Мы регистрируем их сразу для двух типов файлов:
-- "typescriptreact" (TSX) и "javascriptreact" (JSX).
--------------------------------------------------------------------------------
ls.add_snippets("all", {

  -- 1. (BONUS)Interface Creation
  -- Trigger: inter
  s("inter", {
    t "interface Props {",
    t { "", "    " },
    i(1, "// props here"),
    t { "", "}" },
  }),

  -- 2. (BONUS)Console Log
  -- Trigger: c
  s("c", {
    t "console.log(",
    i(1),
    t ")",
  }),

  -- 3. Next 14/15 | Page SEO Component
  -- Trigger: pncs
  s("pncs", {
    t {
      "import type { Metadata } from 'next'",
      "",
      "export const metadata: Metadata = {",
      "    title: '",
    },
    i(1, "title"),
    t "',",
    t { "", "    description: '" },
    i(2, "description"),
    t { "'", "}", "", "export default function " },
    i(3, "PageName"),
    t { "() {", "    return <div>" },
    i(4, "Content"),
    t { "</div>", "}" },
  }),

  -- 4. Next 14/15 | Page No Index Component
  -- Trigger: pnc
  s("pnc", {
    t {
      "import type { Metadata } from 'next'",
      "",
      "import { NO_INDEX_PAGE } from '@/constants/seo.constants'",
      "",
      "export const metadata: Metadata = {",
      "    title: '",
    },
    i(1, "title"),
    t "',",
    t {
      "",
      "    ...NO_INDEX_PAGE  // { robots: { index: false, follow: false } }",
      "}",
      "",
      "export default function ",
    },
    i(2, "PageName"),
    t { "() {", "    return <div>" },
    i(3, "Content"),
    t { "</div>", "}" },
  }),

  -- 5. Next 14/15 | Layout Component
  -- Trigger: lnc
  s("lnc", {
    t {
      "import type { PropsWithChildren } from 'react'",
      "",
      "export default function Layout({ children }: PropsWithChildren<unknown>) {",
      "    return (",
      "        <div>",
      "            ",
    },
    i(1),
    t {
      "",
      "            {children}",
      "        </div>",
      "    )",
      "}",
    },
  }),

  -- 6. Next 14/15 | Client Component
  -- Trigger: cnc
  s("cnc", {
    t { "'use client'", "", "interface Props {}", "", "export function " },
    -- Если хотите автоматически подставлять имя файла, раскомментируйте:
    -- f(filename_base, {}),
    i(1, "MyComponent"), -- или замените на f(filename_base, {}) для автоподстановки
    t { "({}: Props) {", "    return <div>" },
    f(function(args)
      return args[1][1] -- повторяем значение, введённое в i(1)
    end, { 1 }),
    t { "</div>", "}" },
  }),

  -- 7. Next 14/15 & React | Simple Component
  -- Trigger: sc
  s("sc", {
    t "export function ",
    i(1, "MyComponent"),
    t { "() {", "    return <div>" },
    f(function(args) return args[1][1] end, { 1 }),
    t { "</div>", "}" },
  }),

  -- 8. Next 14/15 & React | Simple Component with Interface
  -- Trigger: sci
  s("sci", {
    t "interface Props {}",
    t { "", "", "export function " },
    i(1, "MyComponent"),
    t { "({}: Props) {", "    return <div>" },
    f(function(args) return args[1][1] end, { 1 }),
    t { "</div>", "}" },
  }),

  -- 9. Next 14/15 | Generate Metadata
  -- Trigger: gmd
  s("gmd", {
    t {
      "import type { Metadata } from 'next'",
      "",
      "export async function generateMetadata({",
      "    params,",
      "}: {",
      "    params: { ",
    },
    i(1, "slug:string"),
    t {
      " }",
      "}): Promise<Metadata> {",
      "    const product = await ",
    },
    i(2, "fetchData"),
    t "(",
    f(function(args) return args[1][1] end, { 1 }),
    t {
      ")",
      "    return { title: product.title }",
      "}",
    },
  }),

  -- 10. Next 14/15 | Metadata
  -- Trigger: md
  s("md", {
    t {
      "import type { Metadata } from 'next'",
      "",
      "export const metadata: Metadata = {",
      "    title: '",
    },
    i(1, "title"),
    t "',",
    t { "", "    description: '" },
    i(2, "description"),
    t { "'", "}" },
  }),

  -- 11. Next 14/15 | Generate Static Params
  -- Trigger: gsp
  s("gsp", {
    t {
      "export async function generateStaticParams() {",
      "    const posts = await fetch('",
    },
    i(1, "https://api.example.com/posts"),
    t {
      "').then(res => res.json())",
      "",
      "    return posts.map(post => ({",
      "        slug: post.slug",
      "    }))",
      "}",
    },
  }),

  -- 12. Hook Creation
  -- Trigger: hook
  s("hook", {
    t "export function ",
    -- f(filename_base, {}), -- или i(1, "useCustomHook")
    i(1, "useCustomHook"),
    t { "() {", "    " },
    i(2, "// hook logic"),
    t { "", "    return {}" },
    t { "", "}" },
  }),

  -- 13. Import Styles Module
  -- Trigger: imrs
  s("imrs", {
    t "import styles from './",
    i(1),
    -- f(filename_base, {}), -- Если хотите дополнительно добавить base name
    t ".module.scss'",
  }),

  -- 14. Import clsx as cn
  -- Trigger: imc
  s("imc", {
    t "import cn from 'clsx'",
  }),

  -- 15. Import m from framer-motion
  -- Trigger: imm
  s("imm", {
    t "import { m } from 'framer-motion'",
  }),

  -- 16. Call useAuth Hook
  -- Trigger: usea
  s("usea", {
    t "const { ",
    i(1, "user"),
    t " } = useAuth()",
  }),
})
