local config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    experimental = {
      ghost_text = true,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
          -- elseif copilot_keys ~= "" then -- prioritise copilot over snippets
          --   -- Copilot keys do not need to be wrapped in termcodes
          --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          -- if copilot_keys ~= "" then
          --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
          -- else
          fallback()
          -- end
        end
      end, { "i", "s" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
      -- { name = "copilot", group_index = 2 },
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
    }),
  })

  cmp.setup.cmdline("/", {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
    }),
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  priority = 200,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
  },
  config = config,
}
