local km = vim.keymap

-- clear search highlight
km.set("", "<leader><space>", ":noh<cr>:call clearmatches()<cr>", { silent = true, noremap = true })

-- tab throug parens
km.set("", "<tab>", "%")

-- reselect visual after indent
km.set("v", "<", "<gv", { noremap = true, silent = true })
km.set("v", ">", ">gv", { noremap = true, silent = true })

km.set("n", "<leader>q", "gqip")

km.set("n", "/", "/\\v", { noremap = true })
km.set("v", "/", "/\\v", { noremap = true })

-- Bubble single lines (kicks butt)
km.set("n", "<leader>k", "ddkP")
km.set("n", "<leader>j", "ddp")

-- Bubble multiple lines
km.set("v", "<leader>k", "xkP`[V`]")
km.set("v", "<leader>j", "xp`[V`]")

-- Select pasted text
km.set("n", "<leader>v", "V`]", { noremap = true })

-- sudo-trick.. Save precious changes as root, fuck yeah
km.set("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })

-- Space to toggle folds.
km.set("n", "<space>", "za", { noremap = true })
km.set("v", "<space>", "za", { noremap = true })

-- Set working directory
km.set("n", "<leader>.", ":lcd %:p:h<CR>", { noremap = true })

-- Easy buffer/window/tab navigation
km.set("", "<C-h>", "<C-w>h", { noremap = true })
km.set("", "<C-j>", "<C-w>j", { noremap = true })
km.set("", "<C-k>", "<C-w>k", { noremap = true })
km.set("", "<C-l>", "<C-w>l", { noremap = true })

km.set("", "<M-k>", ":bn<cr>", { noremap = true })
km.set("", "<M-j>", ":bp<cr>", { noremap = true })
km.set("", "<A-k>", ":bn<cr>", { noremap = true })
km.set("", "<A-j>", ":bp<cr>", { noremap = true })

-- Copy/Pasting
km.set("n", "<leader>d", '"+d', { noremap = true })
km.set("n", "<leader>D", '"+D', { noremap = true })
km.set("n", "<leader>y", '"+y', { noremap = true })
km.set("n", "<leader>Y", '"+Y', { noremap = true })
km.set("n", "<leader>p", '"+p', { noremap = true })
km.set("n", "<leader>P", '"+P', { noremap = true })

km.set("x", "<leader>d", '"+d', { noremap = true })
km.set("x", "<leader>D", '"+D', { noremap = true })
km.set("x", "<leader>y", '"+y', { noremap = true })
km.set("x", "<leader>Y", '"+Y', { noremap = true })
km.set("x", "<leader>p", '"+p', { noremap = true })
km.set("x", "<leader>P", '"+P', { noremap = true })

-- Duplicate a line and comment out the first line
km.set("n", "yc", "yy<cmd>normal gcc<CR>p", { noremap = true, desc = "Duplicate line and comment original" })

-- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
km.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
km.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)
km.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
km.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
km.set("n", "<leader>Q", ":lua vim.diagnostic.setloclist()<CR>", opts)
km.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
km.set("n", "gS", ":vsplit<CR>gd", opts)
