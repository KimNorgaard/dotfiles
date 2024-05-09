return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    -- "BufReadPre "
    -- .. vim.fn.expand("~")
    -- .. "/vaults/*/**.md",
    -- "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*/**.md",
    "BufReadPre "
    .. vim.fn.expand("~")
    .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  cmd = {
    "ObsidianToday",
    "ObsidianTomorrow",
    "ObsidianSearch",
    "ObsidianWorkspace",
  },
  keys = {
    { "<leader>nd", ":ObsidianToday<cr>",       desc = "obsidian [d]aily" },
    { "<leader>nt", ":ObsidianToday 1<cr>",     desc = "obsidian [t]omorrow" },
    { "<leader>ny", ":ObsidianToday -1<cr>",    desc = "obsidian [y]esterday" },
    { "<leader>nb", ":ObsidianBacklinks<cr>",   desc = "obsidian [b]acklinks" },
    { "<leader>nl", ":ObsidianLink<cr>",        desc = "obsidian [l]ink selection" },
    { "<leader>nf", ":ObsidianFollowLink<cr>",  desc = "obsidian [f]ollow link" },
    { "<leader>nn", ":ObsidianNew<cr>",         desc = "obsidian [n]ew" },
    { "<leader>ns", ":ObsidianSearch<cr>",      desc = "obsidian [s]earch" },
    { "<leader>no", ":ObsidianQuickSwitch<cr>", desc = "obsidian [o]pen quickswitch" },
    { "<leader>nO", ":ObsidianOpen<cr>",        desc = "obsidian [O]pen in app" },
    { "<leader>nw", ":ObsidianWorkspace<cr>",   desc = "obsidian [W]orkspace" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal",
        -- path = "~/vault",
      },
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },

    notes_subdir = "00-INBOX",
    new_notes_location = "notes_subdir",

    daily_notes = {
      folder = "diary",
    },

    note_id_func = function(title)
      return title
    end,

    -- note_frontmatter_func = function(note)
    --   local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    --   if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
    --     for k, v in pairs(note.metadata) do
    --       out[k] = v
    --     end
    --   end
    --   return out
    -- end,

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
}
