local config  = function()
  local ls = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })

  vim.keymap.set("i", "<C-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })
end

return {
  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = config,
  }
}
