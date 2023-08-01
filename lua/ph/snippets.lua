local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node

local filename = function()
  return f(function(_args, snip)
        local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
        return name[1] or ""
      end)
end

ls.add_snippets("typescriptreact", {
    s(
        "ust",
        fmt("const [{}, {}] = useState<{}>({});", {
            i(1, "state"),
            f(function(args)
              local name = args[1][1]
              local first = string.upper(string.sub(name, 1, 1))
              local rest = string.sub(name, 2, -1)
              return "set" .. first .. rest
            end, { 1 }),
            i(2),
            i(0),
        })
    ),
    s(
        "fcc",
        fmt(
            [[
            export interface {}Props {{}}

            export function {} (props: {}Props){{
              return(
                <div></div>
              )
            }}
    ]],
            {
                filename(),
                filename(),
                filename(),
            }
        )
    ),
}, {
    key = "typescriptreact",
})

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump( -1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
