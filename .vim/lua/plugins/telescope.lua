local config = function()
  local wk = require("which-key")
  local telescope = require('telescope')

  telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
          }
        }
      })

    require('telescope').load_extension('fzf')

    wk.register({
        name = "Finder",
        b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Open buffers" },
        c = { "<cmd>lua require('telescope.builtin').command_history()<CR>", "Command history" },
        f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find files" },
        F = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Fuzzy find in buffer" },
        g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live grep" },
        h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help tags" },
        k = { "<cmd>lua require('telescope.builtin').keymaps()<CR>", "Keymaps" },
        l = { "<cmd>lua require('telescope.builtin').loclist()<CR>", "Location list" },
        o = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Previously open files" },
        q = { "<cmd>lua require('telescope.builtin').quickfix()<CR>", "Quickfix list" },
        r = { "<cmd>lua require('telescope.builtin').registers()<CR>", "Registers" },
        t = { "<cmd>lua require('telescope.builtin').tags()<CR>", "Project tags" },
        u = { "<cmd>lua require('telescope.builtin').resume()<CR>", "Open results of last picker" },
        [":"] = { "<cmd>lua require('telescope.builtin').commands()<CR>", "Search & execute commands" },
        ["/"] = { "<cmd>lua require('telescope.builtin').search_history()<CR>", "Search history" },
      }, { prefix = "<leader>f" })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    lazy = false,
    cmd = {"Telescope"},
    config = config,
  },
}
