return {
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				dim = false,
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.comment").setup()

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			filetype_exclude = { "help", "Trouble", "lazy", "mason" },
		},
		keys = {
			{
				"zr",
				function()
					require("ufo").openFoldsExceptKinds({ "comment", "imports" })
				end,
				desc = "󱃄 Open All Regular Folds",
			},
			{
				"zR",
				function()
					require("ufo").openAllFolds()({})
				end,
				desc = "󱃄 Open All Folds",
			},
		},
		config = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({
					capabilities = capabilities,
					-- you can add other fields for setting up lsp server in this table
				})
			end
			require("ufo").setup(opts)
		end,
	},
	{
		"ojroques/nvim-osc52",
		config = function()
			vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
			vim.keymap.set("n", "<leader>yy", "<leader>c_", { remap = true })
			vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
		end,
	},
}
