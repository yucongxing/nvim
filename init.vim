set encoding=utf-8
set number
set relativenumber
set scrolloff=5
set autochdir
set cursorline
set splitright
set splitbelow
set termguicolors
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set showmatch
set ignorecase
set cinoptions+=g0
syntax on

set ruler
set showcmd
set signcolumn=yes

let mapleader=" "
noremap <silent> <LEADER>rc :e $MYVIMRC<CR>
noremap Q :q<CR>
noremap <silent> <Esc> :call CloseQuickfix()<CR>
noremap <silent> <C-_> :call CommentTheLine()<CR>

augroup _format
  autocmd!
  autocmd BufWritePre *.cpp,*.h,*.py,*.c,*.cxx,*.cc,*.hpp :Format
augroup end

func! CloseQuickfix()
    let ids = getqflist({'winid': 1})
    if get(ids, "winid", 0) != 0
        cclose
    endif
endfunc

func! CommentTheLine()
    if &filetype == 'c'
        exec "normal! I// "
    elseif &filetype == 'cpp'
        exec "normal! I// "
    elseif &filetype == 'python'
        exec "normal! I# "
    elseif &filetype == 'vim'
        exec "normal! I\" "
    endif
endfunc


" Compile function
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<.o"
        :sp
        :res 10
        term ./%<.o
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!clang++ -std=c++17 % -Wall -o %<.o"
        :sp
        :res 10
        :term ./%<.o
    elseif &filetype == 'sh'
        :sp
        :res 10
        :term bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :resize 10
        :term python3 %
    endif
endfunc

call plug#begin('~/.config/nvim/plugged')

" Status line
Plug 'nvim-lualine/lualine.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'

"color scheme
Plug 'overcache/NeoSolarized'
Plug 'navarasu/onedark.nvim'

"completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'rafamadriz/friendly-snippets'

Plug 'windwp/nvim-autopairs'

" neovim-cmake
Plug 'Shatur/neovim-cmake'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"dressing.nvim
Plug 'stevearc/dressing.nvim'

call plug#end()

" NOTE: You can use other key to expand snippet.


" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'

imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}

" nvim-cmp
set completeopt=menu,menuone,noselect

lua << EOF
    local cmp = require'cmp'
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'vsnip'},
        },
        {
            {name = 'buffer'},
            {name = 'path'},
        })
    }

    -- nvim-autopairs

    require('nvim-autopairs').setup{
        fast_wrap = {
            map = "<M-e>",
            chars = {"{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopasdfghjklzxcvbnm",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        }
    }
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

    -- Setup lspconfig.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
      vim.cmd [[command! Format execute 'lua vim.lsp.buf.format({async = true})']]
    end
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = { 'pyright', 'clangd'}
    for _, lsp in pairs(servers) do
      local options = {
          on_attach = on_attach,
          capabilities = capabilities,
      }
      if (lsp == "clangd") then
          local cmd = {
                "clangd",     -- NOTE: 只支持clangd 13.0.0 及其以下版本，新版本会有问题
                "--background-index", -- 后台建立索引，并持久化到disk
                "--compile-commands-dir=build",
                "--clang-tidy", -- 开启clang-tidy
                "--enable-config",
                -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
                "--clang-tidy-checks=bugprone-*, clang-analyzer-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers, google-build-explicit-make-pair, google-build-namespaces, google-build-using-namespace, google-default-arguments, google-explicit-constructor, google-global-names-in-headers",
                "--completion-style=detailed",
                "--cross-file-rename=true",
                "--header-insertion=iwyu",
                "--pch-storage=memory",
                -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
                "--function-arg-placeholders=false",
                "--log=verbose",
                "--ranking-model=decision_forest",
                -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
                "--header-insertion-decorators",
                "-j=12",
                "--pretty",
              }
            -- options = vim.tbl_deep_extend("force", cmd, options)
          options = {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = cmd,
          }
      end
      require('lspconfig')[lsp].setup(options)
    end
EOF

lua << EOF
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "python", "cpp", "bash" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        },
    }
EOF

lua << EOF
    local Path = require('plenary.path')
    require('cmake').setup({
    cmake_executable = 'cmake', -- CMake executable to run.
    parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
    build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values.
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'Projects')), -- Default folder for creating project.
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
    build_args = {'-j8'}, -- Default arguments that will be always passed at cmake build step.
    on_build_output = nil, -- Callback which will be called on every line that is printed during build process. Accepts printed line as argument.
    quickfix_height = 10, -- Height of the opened quickfix.
    quickfix_only_on_error = false, -- Open quickfix window only if target build failed.
    -- dap_configuration = {
    --     type = 'cpp',
    --     request = 'launch',
    --     stopOnEntry = false,
    --     runInTerminal = true,
    -- }, -- DAP configuration. By default configured to work with `lldb-vscode`.
    -- dap_open_command = require('dap').repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
    })
EOF

lua << EOF
  require('lualine').setup()
EOF

colorscheme NeoSolarized
hi Normal ctermfg=252 ctermbg=NONE
