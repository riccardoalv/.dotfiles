local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				flavour = "mocha",
				show_end_of_buffer = true,
				custom_highlights = function(colors)
					return {
						DiagnosticVirtualTextError = { bg = colors.none },
						DiagnosticVirtualTextWarn = { bg = colors.none },
						DiagnosticVirtualTextInfo = { bg = colors.none },
						DiagnosticVirtualTextHint = { bg = colors.none },
					}
				end,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					harpoon = true,
					hop = true,
					lsp_saga = true,
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.notify = require("notify")

			vim.notify.setup({
				timeout = 500,

				background_colour = "#1E1E2E",

				max_width = function()
					return math.ceil(math.max(vim.opt.columns:get() / 3, 10))
				end,
				max_height = function()
					return math.ceil(math.max(vim.opt.lines:get() / 6, 4))
				end,
			})

			local client_notifs = {}

			vim.notify.cmd = function(command)
				local output = ""
				local on_data = function(_, data)
					output = output .. table.concat(data, "\n")
					vim.notify(output, "info")
				end
				vim.fn.jobstart(command, {
					on_stdout = on_data,
					on_stderr = on_data,
					on_exit = function(_, code)
						if #output == 0 then
							vim.notify("No output of command, exit code: " .. code, "warn")
						end
					end,
				})
			end
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({ current_line_blame = true })
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			keymap("n", "<leader>nn", "<cmd>NvimTreeToggle<cr>", opts)
			require("nvim-tree").setup({ view = { side = "right" } })
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
		version = "*",
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = {
				diagnostics = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			}
			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = {
								left = 1,
								right = 0,
							},
						},
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
					},
					lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement")
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant"),
            },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
				extensions = { "lazy" },
			}
		end,
	},
}
