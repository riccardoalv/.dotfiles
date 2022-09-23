local status, packer = pcall(require, "packer")
if not status then
	return
end

packer.init({
	compile_on_sync = true,
})
packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("navarasu/onedark.nvim")
	use("windwp/nvim-autopairs")
	use("andymass/vim-matchup")
	use("kana/vim-submode")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("terrortylor/nvim-comment")
	use("AckslD/nvim-neoclip.lua")
	use("akinsho/bufferline.nvim")
	use("famiu/feline.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("phaazon/hop.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("numtostr/FTerm.nvim")
	use("ThePrimeagen/harpoon")
	use("windwp/nvim-ts-autotag")
	use("ThePrimeagen/refactoring.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("kyazdani42/nvim-web-devicons")
	use("lukas-reineke/indent-blankline.nvim")
	use("lewis6991/gitsigns.nvim")
	use("junegunn/vim-easy-align")
	use("FooSoft/vim-argwrap")
	use("editorconfig/editorconfig-vim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter",
	})

	-- Snippets Plugins
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Debug Section
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")

	-- Lsp/auto Complete Section
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("onsails/lspkind-nvim")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("ray-x/lsp_signature.nvim")
end)
