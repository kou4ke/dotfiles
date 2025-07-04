local luasnip = require("luasnip")
local sni = luasnip.snippet
local txt = luasnip.text_node
local ins = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt
return {
  sni(
    "ret",
    fmt("return {};", { ins(1, "value") })
  ),
}
