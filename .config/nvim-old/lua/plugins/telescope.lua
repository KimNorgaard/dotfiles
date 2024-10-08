return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    lazy = true,
    cmd = { "Telescope" },
    opts = {
      pickers = {
        buffers = {
          theme = "ivy",
          layout_config = {
            height = 24,
            preview_width = 0.55,
          },
        },
        quickfix = {
          theme = "ivy",
          layout_config = {
            height = 30,
            preview_width = 0.50,
          },
        },
        diagnostics = {
          theme = "ivy",
          layout_config = {
            height = 16,
            preview_width = 0.45,
          },
        },
        lsp_references = {
          theme = "dropdown",
          layout_config = {
            width = 0.65,
            height = 0.35,
            anchor = "s",
          },
        },
        lsp_workspace_symbols = {
          theme = "dropdown",
          layout_config = {
            width = 0.65,
            height = 0.35,
            anchor = "s",
          },
        },
        spell_suggest = {
          theme = "cursor",
          layout_config = {
            height = 14,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,              -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
        },
      },
    },
    keys = {
      { "<leader>f",  group = "Finder" },
      { "<leader>f/", "<cmd>lua require('telescope.builtin').search_history()<CR>", desc = "Search history" },
      {
        "<leader>f:",
        "<cmd>lua require('telescope.builtin').commands()<CR>",
        desc = "Search & execute commands",
      },
      {
        "<leader>fF",
        "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
        desc = "Fuzzy find in buffer",
      },
      { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",         desc = "Open buffers" },
      { "<leader>fc", "<cmd>lua require('telescope.builtin').command_history()<CR>", desc = "Command history" },
      {
        "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files()<CR>",
        desc = "Find files",
      },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Live grep" },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Help tags" },
      { "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<CR>",   desc = "Keymaps" },
      { "<leader>fl", "<cmd>lua require('telescope.builtin').loclist()<CR>",   desc = "Location list" },
      {
        "<leader>fo",
        "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
        desc = "Previously open files",
      },
      { "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<CR>",  desc = "Quickfix list" },
      { "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<CR>", desc = "Registers" },
      { "<leader>ft", "<cmd>lua require('telescope.builtin').tags()<CR>",      desc = "Project tags" },
      {
        "<leader>fu",
        "<cmd>lua require('telescope.builtin').resume()<CR>",
        desc = "Open results of last picker",
      },
    },
  },
}
