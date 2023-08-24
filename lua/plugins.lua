-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()


-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])


-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require('packer').startup({function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- use 'tanvirtin/monokai.nvim'
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("plugin-config.nvim-notify")
        end,
    })
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require("plugin-config.nvim-tree")
        end,
    }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim'}
    use { 'neovim/nvim-lspconfig' }
    -- use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }
    -- use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    -- use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' } -- buffer auto-completion
    -- use { 'hrsh7th/cmp-path', after = 'nvim-cmp' } -- path auto-completion
    -- use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' } -- cmdline auto-completion
    -- use 'L3MON4D3/LuaSnip'
    -- use 'saadparwaiz1/cmp_luasnip'
    -- use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    use({
        "nvim-telescope/telescope.nvim",
        -- opt = true,
        -- cmd = "Telescope",
        requires = {
            -- telescope extensions
            --{ "LinArcX/telescope-env.nvim" },
            -- { "nvim-telescope/telescope-ui-select.nvim" },
            {"nvim-lua/plenary.nvim"},
        },
    })
    use("folke/tokyonight.nvim")
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }, config = function()
        require("plugin-config.lualine")
    end})
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } ,  config = function()
        require("plugin-config.lualine")
    end})
    use("arkav/lualine-lsp-progress")
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Projects',
                            group = 'DiagnosticHint',
                            action = 'Telescope projects',
                            key = 'p',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd',
                        },
                    },
                },
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("plugin-config.project")
        end,
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            -- require("nvim-treesitter.install").update({ with_sync = true })
        end,
        requires = {
            { "p00f/nvim-ts-rainbow" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "windwp/nvim-ts-autotag" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        config = function()
            require("plugin-config.nvim-treesitter")
        end,
    })
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    use("onsails/lspkind-nvim")
    use("tami5/lspsaga.nvim" ) -- 新增
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugin-config.indent-blankline")
        end,
    })
    use({
        "kylechui/nvim-surround",
        config = function()
            require("plugin-config.nvim-surround")
        end,
    })

    use("simrat39/rust-tools.nvim")
    use({"windwp/nvim-autopairs" , config = function() require("plugin-config.nvim-autopairs") end,})
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    use("mhartington/formatter.nvim")
    use({ "akinsho/toggleterm.nvim" })
    -- NOTE: PUT YOUR THIRD PLUGIN HERE --
    ---------------------------------------

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end
})

