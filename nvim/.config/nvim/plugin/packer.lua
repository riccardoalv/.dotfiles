local status, packer = pcall(require, "packer")
if not status then
	return
end

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("navarasu/onedark.nvim")
	use("andymass/vim-matchup")
	use("rcarriga/nvim-notify")
	use("kana/vim-submode")
	use("terrortylor/nvim-comment")
	use("AckslD/nvim-neoclip.lua")
	use("akinsho/bufferline.nvim")
	use("famiu/feline.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-lua/plenary.nvim",
		},
	})
	use("nvim-lua/popup.nvim")
	use("phaazon/hop.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/toggleterm.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("kyazdani42/nvim-web-devicons")
	use("lukas-reineke/indent-blankline.nvim")
	use("lewis6991/gitsigns.nvim")
	use("junegunn/vim-easy-align")
	use("FooSoft/vim-argwrap")
	use("editorconfig/editorconfig-vim")

	use({ "tpope/vim-repeat", "tpope/vim-surround" })
	use({ "windwp/nvim-autopairs", "windwp/nvim-ts-autotag" })
	use({ "ThePrimeagen/harpoon", "ThePrimeagen/refactoring.nvim" })

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
		},
	})

	-- Snippets Plugins
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
	})

	-- Debug Section
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")

	-- preview plugins
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		requires = {
			"iamcco/mathjax-support-for-mkdp",
		},
	})

	-- Lsp/auto Complete Section
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	})
	use("onsails/lspkind-nvim")
	use("ray-x/lsp_signature.nvim")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	})
end)
