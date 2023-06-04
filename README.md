# nvim

Personal [`neovim`](https://github.com/neovim/neovim) configuration using [`lazy.nvim`](https://github.com/folke/lazy.nvim) as plugin manager. With a headstarted configuration from [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim).

## Plugins

List of plugins installed and configured to the best of my knowledge, including dependencies. Note that the dependencies might repeat along some plugins.

- [`aplha.lua`](/lua/plugins/alpha.lua) (disabled) [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)
    - [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [`autocompletion.lua`](/lua/plugins/autocompletion.lua) [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [`dracula.lua`](/lua/plugins/dracula.lua) (colorscheme) [Mofiqul/dracula.nvim](https://github.com/Mofiqul/dracula.nvim)
- [`gitsigns.lua`](/lua/plugins/gitsigns.lua) [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [`indent-blankline.lua`](/lua/plugins/indent-blankline.lua) [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [`lsp.lua`](/lua/plugins/lsp.lua) [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    - [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
    - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
    - [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim)
    - [folke/neodev.nvim](https://github.com/folke/neodev.nvim)
- [`lualine.lua`](/lua/plugins/lualine.lua) [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [`neo-tree.lua`](/lua/plugins/neo-tree.lua) [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
    - [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
    - [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)
    - [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [`telescope.lua`](/lua/plugins/telescope.lua) [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    - [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
    - [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [`treesitter.lua`](/lua/plugins/treesitter.lua) [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [`undotree.lua`](/lua/plugins/undotree.lua) [mbbill/undotree](https://github.com/mbbill/undotree)

Non configured plugins residing in [`init.lua`](/lua/plugins/init.lua):

- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb)
- [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
