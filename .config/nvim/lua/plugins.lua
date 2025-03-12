---@diagnostic disable:undefined-global
--- vim: foldmethod=marker foldlevel=0

local map = require("util").map

-- mini.nvim {{{
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
-- }}}

-- mini.deps {{{
-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- }}}

now(function()
	-- mini.ai {{{
	require("mini.ai").setup()
	-- }}}

	-- mini.icons {{{
	require("mini.icons").setup()
	MiniIcons.mock_nvim_web_devicons()
	-- }}}

	-- mini.notify {{{
	require("mini.notify").setup()
	vim.notify = require("mini.notify").make_notify()
	vim.api.nvim_create_user_command("NotifyShowHistory", "lua require('mini.notify').show_history()", {})
	-- }}}

	-- mini.files {{{
	require("mini.files").setup()
	map("n", "<leader>E", MiniFiles.open, "Open MiniFiles")
	-- }}}

	-- gitsigns.nvim {{{
	add({
		source = "lewis6991/gitsigns.nvim",
	})
	require("gitsigns").setup()
	map("n", "gb", "<cmd>Gitsigns blame_line<CR>", "Show git blame for line")
	-- }}}

	-- treesitter {{{
	add({
		source = "nvim-treesitter/nvim-treesitter",
		-- Use 'master' while monitoring updates in 'main'
		checkout = "master",
		-- monitor = "main",
		-- Perform action after every checkout
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	add("RRethy/nvim-treesitter-endwise")
	require("nvim-treesitter.configs").setup({
		-- ensure_installed = { "lua", "vim", "go", "terraform", "python" },
		endwise = { enable = true },
		indent = { enable = true },
		highlight = {
			enable = true,
			disable = function(_, buf)
				-- if lang == "go" then
				--   return true
				-- end
				local max_filesize = 1 * 1024 * 1024 -- 1 MB
				local _ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if _ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	})
	-- }}}

	-- markdown {{{
	add({
		source = "Tweekism/markdown-preview.nvim",
		hooks = {
			post_checkout = function()
				vim.fn["mkdp#util#install"]()
			end,
		},
	})
	add({
		source = "OXY2DEV/markview.nvim",
		depends = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	})
	local presets = require("markview.presets")
	require("markview").setup({
		enable = true,
		markdown = {
			enable = true,
			headings = presets.headings.glow,
		},
		markdown_inline = {
			enable = true,
			checkboxes = presets.checkboxes.nerd,
		},
		preview = {
			enable = false,
			icon_provider = "devicons",
			filetypes = { "md", "markdown", "codecompanion" },
			max_buf_lines = 5000,
			ignore_buftypes = {},
		},
	})
	-- }}}
end)

later(function()
	-- mini.extra {{{
	require("mini.extra").setup()
	-- }}}

	-- mini.surround {{{
	require("mini.surround").setup()
	-- }}}

	-- mini.diff {{{
	require("mini.diff").setup()
	-- }}}

	-- mini.git {{{
	vim.g.minigit_disable = true
	require("mini.git").setup()
	map({ "n", "x" }, "<leader>ga", MiniGit.show_at_cursor, "Git show at cursor")
	map({ "n", "v" }, "<leader>gh", MiniGit.show_range_history, "Git show range history")
	map({ "n", "v" }, "<leader>gd", MiniGit.show_diff_source, "Git show diff source")
	-- }}}

	-- mini.bufremove {{{
	require("mini.bufremove").setup()
	map("n", "<leader>bd", "<cmd>lua MiniBufremove.delete(0, false)<CR>", "Buf delete")
	map("n", "<leader>bD", "<cmd>lua MiniBufremove.delete(0, true)<CB>", "Buf delete (force)")
	-- }}}

	-- mini.pick {{{
	require("mini.pick").setup({
		mappings = {
			move_up = "<C-k>",
			move_down = "<C-j>",
		},
	})
	vim.ui.select = MiniPick.ui_select
	local show_with_icons = function(buf_id, items, query)
		return MiniPick.default_show(buf_id, items, query, { show_icons = true })
	end
	-- pick grep function that pass args to rg
	MiniPick.registry.grep_args = function()
		local args = vim.fn.input("Ripgrep args: ")
		local command = {
			"rg",
			"--column",
			"--line-number",
			"--no-heading",
			"--field-match-separator=\\0",
			"--no-follow",
			"--color=never",
		}
		local args_table = vim.fn.split(args, " ")
		vim.list_extend(command, args_table)

		return MiniPick.builtin.cli(
			{ command = command },
			{ source = { name = string.format("Grep (rg %s)", args), show = show_with_icons } }
		)
	end
	local function filter_buffers(pattern, cmd_opts)
		cmd_opts = cmd_opts or {}
		local items = {}
		local buffers_output =
			vim.api.nvim_exec2("filter" .. (cmd_opts.revert and "! " or " ") .. pattern .. " ls", { output = true })
		if buffers_output.output ~= "" then
			for _, l in ipairs(vim.split(buffers_output.output, "\n")) do
				local buf_str, name = l:match("^%s*%d+"), l:match('"(.*)"')
				local buf_id = tonumber(buf_str)
				local item = { text = name, bufnr = buf_id }
				table.insert(items, item)
			end
		end
		return items
	end
	local function get_terminal_items(_)
		local dap_terms = filter_buffers("/^\\[dap-terminal\\]/")
		local terms = filter_buffers("/^term:\\/\\//")
		return vim.list_extend(terms, dap_terms)
	end
	-- select terminals
	MiniPick.registry.terminals = function(local_opts)
		local items = get_terminal_items(local_opts)
		local terminal_opts = { source = { name = "Terminal buffers", show = show_with_icons, items = items } }
		return MiniPick.start(terminal_opts)
	end
	vim.api.nvim_create_user_command("PickOrNewTerminal", function()
		local items = get_terminal_items()
		if #items == 0 then
			vim.cmd("terminal")
		elseif #items == 1 then
			vim.cmd("buffer " .. items[1].bufnr)
		else
			vim.cmd("Pick terminals")
		end
	end, { desc = "Format changed lines" })
	map("n", "<leader>ft", "<cmd>PickOrNewTerminal<cr>", "Pick terminals or new one")
	map("n", "<leader>fG", "<cmd>Pick grep_args<cr>", "Pick grep with rg args")
	map("n", "<leader>ff", "<cmd>Pick files<cr>", "Pick files")
	map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", "Pick grep live")
	map("n", "<leader>fH", "<cmd>Pick help<cr>", "Pick help")
	map("n", "<leader>fb", "<cmd>Pick buffers<cr>", "Pick buffers")
	map("n", "<leader>fc", "<cmd>Pick cli<cr>", "Pick cli")
	map("n", "<leader>fR", "<cmd>Pick resume<cr>", "Pick resume")
	map("n", "<leader>fd", "<cmd>Pick diagnostic scope='current'<cr>", "Pick current diagnostic")
	map("n", "<leader>fD", "<cmd>Pick diagnostic scope='all'<cr>", "Pick all diagnostic")
	map("n", "<leader>gb", "<cmd>Pick git_branches<cr>", "Pick git branches")
	map("n", "<leader>gC", "<cmd>Pick git_commits<cr>", "Pick git commits")
	map("n", "<leader>gc", "<cmd>Pick git_commits path='%'<cr>", "Pick git commits current")
	map("n", "<leader>gf", "<cmd>Pick git_files<cr>", "Pick git files")
	map("n", "<leader>gH", "<cmd>Pick git_hunks<cr>", "Pick git hunks")
	map("n", "<leader>fP", "<cmd>Pick hipatterns<cr>", "Pick hipatterns")
	map("n", "<leader>fh", "<cmd>Pick history<cr>", "Pick history")
	map("n", "<leader>fL", "<cmd>Pick hl_groups<cr>", "Pick hl groups")
	map("n", "<leader>fk", "<cmd>Pick keymaps<cr>", "Pick keymaps")
	map("n", "<leader>fl", "<cmd>Pick list scope='location'<cr>", "Pick location")
	map("n", "<leader>fj", "<cmd>Pick list scope='jump'<cr>", "Pick jump")
	map("n", "<leader>fq", "<cmd>Pick list scope='quickfix'<cr>", "Pick quickfix")
	map("n", "<leader>fC", "<cmd>Pick list scope='change'<cr>", "Pick change")
	map("n", "<leader>fm", "<cmd>Pick marks<cr>", "Pick marks")
	map("n", "<leader>fo", "<cmd>Pick oldfiles<cr>", "Pick oldfiles")
	map("n", "<leader>fO", "<cmd>Pick options<cr>", "Pick options")
	map("n", "<leader>fr", "<cmd>Pick registers<cr>", "Pick registers")
	map("n", "<leader>fp", "<cmd>Pick spellsuggest<cr>", "Pick spell suggest")
	map("n", "<leader>fT", "<cmd>Pick treesitter<cr>", "Pick treesitter")
	map("n", "<leader>fv", "<cmd>Pick visit_paths<cr>", "Pick visit paths")
	map("n", "<leader>fV", "<cmd>Pick visit_labels<cr>", "Pick visit labels")
	map("n", "<leader>cd", "<cmd>Pick lsp scope='definition'<CR>", "Pick lsp definition")
	map("n", "<leader>cD", "<cmd>Pick lsp scope='declaration'<CR>", "Pick lsp declaration")
	map("n", "<leader>cr", "<cmd>Pick lsp scope='references'<cr>", "Pick lsp references")
	map("n", "<leader>ci", "<cmd>Pick lsp scope='implementation'<CR>", "Pick lsp implementation")
	map("n", "<leader>ct", "<cmd>Pick lsp scope='type_definition'<cr>", "Pick lsp type definition")
	map("n", "<leader>fs", "<cmd>Pick lsp scope='document_symbol'<cr>", "Pick lsp document symbol")
	map(
		"n",
		"<leader>fS",
		"<cmd>Pick lsp scope='workspace_symbol' symbol_query=vim.fn.input('Symbol:\\ ')<cr>",
		"Pick lsp workspace symbol"
	)
	-- }}}

	-- mini.clue {{{
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },

			-- mini.surround
			{ mode = "n", keys = "s" },
		},
		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	})
	-- }}}

	-- mini.snippets {{{
	local gen_loader = require("mini.snippets").gen_loader
	require("mini.snippets").setup({
		snippets = {
			-- Load custom file with global snippets first (adjust for Windows)
			gen_loader.from_file("~/.config/nvim/snippets/global.json"),

			-- Load snippets based on current language by reading files from
			-- "snippets/" subdirectories from 'runtimepath' directories.
			gen_loader.from_lang(),
		},
	})
	-- }}}

	-- lsp {{{
	add({
		source = "neovim/nvim-lspconfig",
		depends = {
			"saghen/blink.cmp",
			"nvimtools/none-ls.nvim",
		},
	})

	local lspconfig = require("lspconfig")

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(_, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		-- vim.keymap.set("n", "<space>wl", function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, bufopts)
		-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		-- vim.keymap.set("n", "<space>f", function()
		--   vim.lsp.buf.format({ async = true })
		-- end, bufopts)
	end

	-- Enable some language servers with the additional completion capabilities offered
	local servers = {
		"gopls",
		"bashls",
		"pyright",
		"ruff",
		"lua_ls",
		"ts_ls",
		"eslint",
		"jsonls",
		"terraformls",
		"jsonnet_ls",
	}
	for _, lsp in ipairs(servers) do
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end

	lspconfig.bashls.setup({})

	lspconfig.jsonls.setup({
		settings = {
			provideFormatter = true,
			json = {
				format = {
					enable = true,
				},
				validate = {
					enable = true,
				},
			},
		},
	})

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	lspconfig.pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					ignore = { "*" },
				},
			},
		},
	})

	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		single_file_support = false,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literal",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})

	lspconfig.gopls.setup({
		-- on_attach = function(client, bufnr)
		--   require("lsp-inlayhints").setup({
		--     inlay_hints = {
		--       xonly_current_line = true,
		--     },
		--   })
		--   require("lsp-inlayhints").on_attach(client, bufnr)
		-- end,
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			-- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
			gopls = {
				analyses = {
					nilness = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
				},
				completeUnimported = true,
				experimentalPostfixCompletions = true,
				gofumpt = true,
				-- staticcheck = true,
				usePlaceholders = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})
	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
	vim.diagnostic.config({
		virtual_text = true,
		float = {
			header = false,
			style = "minimal",
			border = "rounded",
			focusable = false,
		},
	})

	vim.b.lsp_diagnostic_enabled = false
	local toggle_virtual_text = function()
		vim.b.lsp_diagnostic_enabled = not vim.b.lsp_diagnostic_enabled
		vim.notify(string.format("Virtualtext %s", vim.b.lsp_diagnostic_enabled and "on" or "off"))
		vim.diagnostic.show(nil, 0, nil, { virtual_text = vim.b.lsp_diagnostic_enabled })
	end
	vim.keymap.set("n", "<leader>dt", toggle_virtual_text, { desc = "[diagnostic] toggle display of diagnostic" })

	add({
		source = "nvimtools/none-ls.nvim",
		depends = {
			"nvim-lua/plenary.nvim",
			"gbprod/none-ls-shellcheck.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
	})
	local function is_null_ls_formatting_enabed(bufnr)
		local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local generators =
			require("null-ls.generators").get_available(file_type, require("null-ls.methods").internal.FORMATTING)
		return #generators > 0
	end

	local on_nls_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			if client.name == "null-ls" and is_null_ls_formatting_enabed(bufnr) or client.name ~= "null-ls" then
				vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
				vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
			else
				vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
			end
		end
	end

	local nls = require("null-ls")
	local sources = {}
	table.insert(sources, nls.builtins.formatting.isort)
	table.insert(sources, nls.builtins.formatting.black.with({ extra_args = { "--fast" } }))
	table.insert(sources, nls.builtins.formatting.terraform_fmt)
	table.insert(sources, nls.builtins.formatting.shfmt)
	-- table.insert(sources, nls.builtins.formatting.prettierd)
	table.insert(
		sources,
		nls.builtins.formatting.prettierd.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				-- 'markdown',
				-- 'markdown.mdx',
				"graphql",
				"handlebars",
			},
		})
	)
	table.insert(
		sources,
		nls.builtins.diagnostics.markdownlint.with({
			extra_args = { "--disable", "MD013", "MD033" },
		})
	)
	table.insert(sources, nls.builtins.diagnostics.yamllint)
	table.insert(sources, nls.builtins.diagnostics.staticcheck)
	table.insert(
		sources,
		nls.builtins.diagnostics.vale.with({
			filetypes = { "markdown", "tex", "text", "mail" },
			diagnostic_config = {
				virtual_text = false,
			},
		})
	)
	table.insert(sources, nls.builtins.hover.dictionary)
	nls.setup({
		on_attach = on_nls_attach,
		sources = sources,
	})

	add({
		source = "ray-x/lsp_signature.nvim",
	})
	require("lsp_signature").setup({
		hints_enable = false,
	})
	-- }}}

	-- cmp {{{
	add({ source = "giuxtaposition/blink-cmp-copilot" })

	add({
		source = "saghen/blink.cmp",
		depends = {
			"echasnovski/mini.snippets",
			"giuxtaposition/blink-cmp-copilot",
		},
		checkout = "v0.13.1",
	})

	require("blink.cmp").setup({
		-- keymap = { preset = "super-tab" },
		keymap = {
			preset = "default",
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
					components = {
						kind_icon = {
							ellipsis = false,
							-- text = function(ctx)
							-- 	local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							-- 	return kind_icon
							-- end,
							-- Optionally, you may also use the highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
			ghost_text = { enabled = true },
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = true } },
			list = {
				selection = {
					preselect = function(_)
						return vim.bo.filetype ~= "markdown"
					end,
					auto_insert = true,
				},
			},
			trigger = {
				show_in_snippet = true,
			},
		},
		signature = { window = { border = "rounded" } },
		snippets = { preset = "mini_snippets" },
		sources = {
			default = { "lsp", "copilot", "path", "buffer", "snippets" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
		},
		appearance = {
			-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
	})
	-- }}}

	-- lint {{{
	add({ source = "mfussenegger/nvim-lint" })
	require("lint").linters_by_ft = {
		javascript = { "eslint" },
		typescript = { "eslint" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
	-- }}}

	-- conform {{{
	add({ source = "stevearc/conform.nvim" })
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			-- FormatDisable! will disable formatting just for this buffer
			vim.b.disable_autoformat = true
			vim.notify("Autoformat disabled for this buffer", vim.log.levels.INFO, { title = "Conform" })
		else
			vim.g.disable_autoformat = true
			vim.notify("Autoformat disabled", vim.log.levels.INFO, { title = "Conform" })
		end
	end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	})
	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
		vim.notify("Autoformat enabled", vim.log.levels.INFO, { title = "Conform" })
	end, {
		desc = "Re-enable autoformat-on-save",
	})
	require("conform").setup({
		formatters_by_ft = {
			-- Use a sub-list to run only the first available formatter
			javascript = { "prettierd", "prettier", stop_after_first = true },
			lua = { "stylua" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			local ignore_filetypes = { "html", "go" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	})
	map({ "n", "x", "o" }, "<leader>bf", function()
		require("conform").format({ async = true, lsp_format = "fallback" })
	end, "Format buffer")
	-- }}}

	-- obsidian {{{
	add({
		source = "epwalsh/obsidian.nvim",
		depends = {
			"nvim-lua/plenary.nvim",
		},
	})
	require("obsidian").setup({
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
			name = "mini.pick",
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
	})
	map("n", "<leader>nd", ":ObsidianToday<cr>", "obsidian [d]aily")
	map("n", "<leader>nt", ":ObsidianToday 1<cr>", "obsidian [t]omorrow")
	map("n", "<leader>ny", ":ObsidianToday -1<cr>", "obsidian [y]esterday")
	map("n", "<leader>nb", ":ObsidianBacklinks<cr>", "obsidian [b]acklinks")
	map("n", "<leader>nl", ":ObsidianLink<cr>", "obsidian [l]ink selection")
	map("n", "<leader>nf", ":ObsidianFollowLink<cr>", "obsidian [f]ollow link")
	map("n", "<leader>nn", ":ObsidianNew<cr>", "obsidian [n]ew")
	map("n", "<leader>ns", ":ObsidianSearch<cr>", "obsidian [s]earch")
	map("n", "<leader>no", ":ObsidianQuickSwitch<cr>", "obsidian [o]pen quickswitch")
	map("n", "<leader>nO", ":ObsidianOpen<cr>", "obsidian [O]pen in app")
	map("n", "<leader>nw", ":ObsidianWorkspace<cr>", "obsidian [W]orkspace")
	-- }}}

	-- llm/ai {{{
	add({ source = "nvim-lua/plenary.nvim" })

	add({ source = "zbirenbaum/copilot.lua" })
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			go = true,
			python = true,
			sh = true,
			yaml = true,
			terraform = true,
			["*"] = false,
		},
	})
	map("n", "<leader>ca", ":Copilot! attach<CR>", "Attach Copilot")
	map("n", "<leader>cs", ":Copilot toggle<CR>", "Copilot Suggestion Toggle")

	add({ source = "stevearc/dressing.nvim" })
	add({
		source = "olimorris/codecompanion.nvim",
		depends = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
		},
	})
	map("n", "<leader>cc", ":CodeCompanionChat Toggle<CR>", "CodeCompanionChat")
	map({ "n", "v" }, "<leader>cb", ":CodeCompanion #buffer ", "CodeCompanion")
	vim.cmd([[cab cc CodeCompanion]])
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "gemini",
				slash_commands = {
					["file"] = {
						callback = "strategies.chat.slash_commands.file",
						description = "Select a file using mini.pick",
						opts = {
							provider = "mini_pick", -- Other options include 'default', 'mini_pick', 'fzf_lua'
							contains_code = true,
						},
					},
				},
			},
			inline = {
				adapter = "copilot",
			},
			agent = {
				adapter = "copilot",
			},
		},
		adapters = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "GEMINI_API_KEY",
					},
					schema = {
						model = {
							default = "gemini-1.5-pro-latest",
						},
					},
				})
			end,
		},
		display = {
			action_palette = {
				provider = "mini_pick",
			},
			diff = {
				provider = "mini_diff",
			},
			chat = {
				diff = {
					enabled = true,
					provider = "mini_diff", -- default|mini_diff
				},
			},
		},
	})
	-- }}}

	-- tabular {{{
	add({
		source = "godlygeek/tabular",
	})
	map({ "n", "v" }, "<leader>a=", ":Tabularize /=<CR>", "Tabularize on =")
	map({ "n", "v" }, "<leader>a:", ":Tabularize /:\\zs=<CR>", "Tabularize on :")
	-- }}}

	-- neotree {{{
	add({
		source = "nvim-neo-tree/neo-tree.nvim",
		depends = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})
	map("n", "<leader>F", ":Neotree toggle<CR>", "Toggle Neotree")
	-- }}}

	-- go {{{
	add({
		source = "ray-x/go.nvim",
		depends = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		hooks = {
			post_checkout = function()
				require("go.install").update_all_sync()
			end,
		},
	})
	add({
		source = "ray-x/guihua.lua",
	})
	require("go").setup({
		run_in_floaterm = false,
		lsp_codelens = false,
		lsp_inlay_hints = {
			enable = false,
		},
	})
	-- }}}

	-- ledger {{{
	add({
		-- source = "wllfaria/ledger.nvim",
		source = "~/src/github/KimNorgaard/ledger.nvim",
		checkout = "feat/blink-support",
		depends = {
			"nvim-treesitter/nvim-treesitter",
		},
	})
	local opts = {
		extensions = {
			"commodities.ldg",
			"accounts.ldg",
		},
		completion = {
			cmp = { enabled = false },
		},
	}
	require("ledger").setup(opts)
	map("n", "<leader>A", "vip:LedgerAlign<cr>", "Ledger align")

	Hledger = require("hledger")

	vim.keymap.set(
		{ "n", "v" },
		"<leader>h",
		":<c-u>lua Hledger.hledger_align_entry()<cr>",
		{ noremap = true, silent = true }
	)
	vim.keymap.set(
		"n",
		"<leader>H",
		"vip:<c-u>lua Hledger.hledger_align_entry()<cr>",
		{ noremap = true, silent = true }
	)

	vim.g.ledger_align_at = 80
	-- }}}

	-- moonwalk {{{
	add({ source = "theJian/nvim-moonwalk" })
	-- }}}
end)
