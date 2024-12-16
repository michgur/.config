local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  -- s("po", fmt("poop time \n poop {} poop {} \n end of poop time", { i(1), i(0) })),
})
