local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

vim.opt.termguicolors = true

plugins = {
    'neovim/nvim-lspconfig',
    'luochen1990/rainbow',
    'itchyny/vim-cursorword',
    'vim-scripts/a.vim',
    'godlygeek/tabular',
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<C-x>u', vim.cmd.UndotreeToggle)
        end,

    },
    'justinmk/vim-syntax-extra',
    {
        'airblade/vim-gitgutter',
        config = function()
            vim.keymap.set('n', ']h', '<Plug>(GitGutterNextHunk)', { silent = true })
            vim.keymap.set('n', '[h', '<Plug>(GitGutterPrevHunk)', { silent = true })
            vim.keymap.set('n', '<leader>s', '<Plug>(GitGutterStageHunk)', { silent = true })
            vim.keymap.set('n', '<leader>u', '<Plug>(GitGutterUndoHunk)', { silent = true })
            vim.keymap.set('n', '<leader>p', '<Plug>(GitGutterPreviewHunk)', { silent = true })
        end,
    },
    {
        'scrooloose/nerdtree',
        config = function()
            vim.g.NERDTreeMinimalUI = 1
            vim.keymap.set('n', '<C-n>', ':NERDTreeToggle %<CR>')
        end,
    },
    {
        'scrooloose/nerdcommenter',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>c', ':call nerdcommenter#Comment("n", "Toggle")<CR>',
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', '<leader>c', ':call nerdcommenter#Comment("n", "Toggle")<CR>',
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>a', ':call NERDComment("n", "Append")<CR>',
                { noremap = true, silent = true })
        end,
    },
    {
        'crusoexia/vim-monokai',
        config = function()
            vim.g.monokai_term_italic = 0
            vim.g.monokai_gui_italic = 0
            vim.cmd('colorscheme monokai')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'go', 'lua', 'rust', 'javascript', 'typescript', 'c', 'cpp', 'python', 'yaml', 'bash', 'json', 'css', 'html', 'wgsl', 'asm', 'make', 'vim', 'tmux', 'toml', 'markdown', 'terraform', 'cuda', 'glsl', 'jq', 'helm', 'gpg', 'csv', 'dockerfile', 'gdscript', 'sql' },
            highlight = { enable = true },
        },
    },
    {
        'itchyny/lightline.vim',
        config = function()
            vim.g.lightline = { enable = { tabline = 0 } }
        end,
    },
    'windwp/nvim-autopairs',
    {
        'easymotion/vim-easymotion',
        config = function()
            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_smartcase = 1
            vim.keymap.set({ 'n', 'v' }, 'f', '<Plug>(easymotion-s2)', {})
        end,
    },
    {
        'justinmk/vim-sneak',
        config = function()
            vim.g['sneak#label'] = 1
            vim.g['sneak#s_next'] = 1
        end,
    },
    'junegunn/fzf',
    {
        'junegunn/fzf.vim',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>e', ':GFiles<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>E', ':Files<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>l', ':BLines<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>L', ':Lines<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>f', ':Ag<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>F', ':Ag <C-r>"<CR>', { noremap = true, silent = true })
        end,
    },
    'moll/vim-node',
    'MunifTanjim/prettier.nvim',
    'jelera/vim-javascript-syntax',
    'dhruvasagar/vim-table-mode',
    'tikhomirov/vim-glsl',
    'DingDean/wgsl.vim',
    'hashivim/vim-terraform',
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({
                notification = {
                    window = { winblend = 0 },
                },
            })
        end,
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    },
    'OXY2DEV/markview.nvim',
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'buffers',
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = 'thin',
                    diagnostics = 'nvim_lsp',
                },
                highlights = {
                    buffer_selected = { italic = false },
                    diagnostic_selected = { italic = false },
                    hint_selected = { italic = false },
                    hint_diagnostic_selected = { italic = false },
                    info_selected = { italic = false },
                    info_diagnostic_selected = { italic = false },
                    warning_selected = { italic = false },
                    warning_diagnostic_selected = { italic = false },
                    error_selected = { italic = false },
                    error_diagnostic_selected = { italic = false },
                    duplicate_selected = { italic = false },
                    duplicate_visible = { italic = false },
                    duplicate = { italic = false },
                },
            })
            vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
            vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
            vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
            vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
            vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
            vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
            vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
            vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
            vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
        end,
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup()
        end,
    }
}

require("lazy").setup(plugins)

-- quick save/close
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':qa!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':bd!<CR>', { noremap = true, silent = true })

-- vim features
vim.api.nvim_set_keymap('n', 'gj', 'J', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '@', ':normal @', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>\\', ':', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = false })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true, silent = false })

-- C-j C-k to scroll
vim.api.nvim_set_keymap('n', '<C-j>', '<C-d>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-u>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-j>', '<C-d>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-k>', '<C-u>', { noremap = true, silent = true })

-- prev buffer
vim.api.nvim_set_keymap('n', '<leader>;', ':buffer #<CR>', { noremap = true, silent = true })

-- center and clear search on C-l
vim.api.nvim_set_keymap('n', '<C-l>', 'zz<C-l>:nohlsearch<CR>', { noremap = true, silent = true })

-- tab navigation
vim.api.nvim_set_keymap('n', 'J', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':bnext<CR>', { noremap = true, silent = true })

-- emacs like C-a C-e nav
vim.api.nvim_set_keymap('n', '<C-a>', '0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-e>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-a>', '0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-e>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<C-o>0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<C-o>$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-e>', '<End>', { noremap = true, silent = true })

-- unmap all keys on \c so nerdcommenter doesnt wait for a potential next key
vim.cmd([[
:unmap <leader>cc
:unmap <leader>ca
:unmap <leader>cu
:unmap <leader>cb
:unmap <leader>cl
:unmap <leader>cA
:unmap <leader>cy
:unmap <leader>cs
:unmap <leader>ci
:unmap <leader>c$
:unmap <leader>cn
:unmap <leader>cm
:unmap <leader>c<space>
]])

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 1
vim.opt.wrap = false

-- use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- scroll 7 lines before top/bottom of the window
vim.opt.scrolloff = 7

-- disable mouse
vim.opt.mouse = ""

-- folding config
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

function MarkdownFoldLevel(lnum)
    local line = vim.fn.getline(lnum)
    local header_level = line:match('^(#+)%s')
    if header_level then
        return '>' .. #header_level
    end
    return '='
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.MarkdownFoldLevel(v:lnum)'
    end
})

function ToggleFoldAll()
    if vim.wo.foldlevel == 0 then
        vim.wo.foldlevel = 99
    else
        vim.wo.foldlevel = 0
    end
end

vim.api.nvim_set_keymap('n', '<leader>z', ':lua ToggleFoldAll()<CR>', { noremap = true, silent = true })

vim.diagnostic.config({
    virtual_text = { prefix = '●', spacing = 2 },
    float = {
        source = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.keymap.set('n', '[<space>', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']<space>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>[', vim.diagnostic.setloclist)

-- set up completion options
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.pumheight = 5

-- quick git blame
vim.keymap.set('n', 'gb', ':execute "!git blame -L" . line(".") . ",+1 %"<CR>')


vim.lsp.enable('pyright')
vim.lsp.enable('ts_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('wgsl_analyzer')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('buf_ls')

vim.lsp.config('gopls', {
    settings = {
        gopls = {
            gofumpt = true,
        },
    },
})
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {},
    },
})
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
        },
    },
})

vim.keymap.set('n', '<leader><space>', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>h', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gn', vim.lsp.buf.rename)
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.bo[ev.buf].formatexpr = 'v:lua.vim.lsp.buf.format()'

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end
        })
    end,
})
