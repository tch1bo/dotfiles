call plug#begin(stdpath('data') . '/plugged')

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
" Plug 'numToStr/Comment.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/google.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'joshdick/onedark.vim'
Plug 'AlexvZyl/nordic.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'preservim/nerdtree'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
" Dependencies for telescope:
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fannheyward/telescope-coc.nvim'
" Plug 'nvim-tree/nvim-web-devicons'
Plug 'mhinz/vim-startify'
" syntax highlight for vue files
Plug 'posva/vim-vue'
Plug 'alexander-born/bazel.nvim', {'dependencies': 'nvim-treesitter/nvim-treesitter'}


call plug#end()

nnoremap <C-n> :NERDTreeFind<CR>

" Plug 'numToStr/Comment.nvim'
" lua require('Comment').setup()

" Plug 'mhinz/vim-startify'
let g:startify_change_to_dir=0
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_session_dir = '~/.config/nvim/session'

" Plug 'easymotion/vim-easymotion'
map  sw <Plug>(easymotion-prefix)
map  sl <Plug>(easymotion-bd-jk)

" Plug 'ntpeters/vim-better-whitespace'
highlight ExtraWhitespace ctermbg=darkred
let g:strip_whitespace_on_save=1
let g:better_whitespace_enabled=1
let g:strip_whitespace_confirm=0

" Plug 'vim-scripts/google.vim'
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Plug 'google/vim-glaive'
call glaive#Install()
Glaive codefmt clang_format_style='file'
Glaive codefmt prettier_executable='prettier'
autocmd BufRead *.js let b:codefmt_formatter = 'prettier'
autocmd BufRead *.ts let b:codefmt_formatter = 'prettier'
autocmd BufRead *.py let b:codefmt_formatter = 'black'

" Colorscheme.
" Plug 'joshdick/onedark.vim'
" syntax enable
" colorscheme onedark

syntax on
set t_Co=256
set background=dark
set termguicolors
colorscheme nordic

" Plug 'bling/vim-airline'
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline_section_b = ''
let g:airline_section_y = ''

" Plug 'neoclide/coc.nvim',
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gh :CocCommand clangd.switchSourceHeader<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Other configs.
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set statusline+=%F
set laststatus=2

" Clipboard settings for copy-pasting.
set clipboard+=unnamedplus
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
      \      '+': 'xsel --input --clipboard',
      \      '*': 'xsel --input --primary',
      \    },
      \   'paste': {
      \      '+': 'xsel --output --clipboard',
      \      '*': 'xsel --output --primary',
      \   },
      \   'cache_enabled': 1,
      \ }


au BufRead *.c set colorcolumn=100 "show red line
au BufRead *.cpp set colorcolumn=100 "show red line
au BufRead *.h set colorcolumn=100 "show red line
au BufRead *.py set colorcolumn=100 "show red line
au BufRead *.tex set colorcolumn=100 "show red line
au BufRead *.js set colorcolumn=100 "show red line
au BufRead *.vue set colorcolumn=100 "show red line
au BufRead *.plog set syntax=prolog
au BufRead *.star setlocal commentstring=#\ %s

function! SplitIfNotOpen(...)
  let fname = a:1
  let call = ''
  if a:0 == 2
    let fname = a:2
    let call = a:1
  endif
  let bufnum=bufnr(expand(fname))
  let winnum=bufwinnr(bufnum)
  if winnum != -1
    " Jump to existing split
    exe winnum . "wincmd w"
  else
    " Make new split as usual
    exe "vsplit " . fname
    exe "normal \<C-w>L"
  endif
  " Execute the cursor movement command
  exe call
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)

" Detect python files in some special folders
" autocmd FileType python let b:coc_root_patterns = ['bazel-bin/dist/codegen']

" Plug 'nvim-telescope/telescope.nvim'
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-m> <cmd>Telescope live_grep<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" nnoremap <C-g> <cmd>(Telescope grep_string)<cr>
nnoremap <C-g> :lua require'telescope.builtin'.grep_string{}<cr>
nnoremap <C-e> :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>
nnoremap "" :lua require'telescope.builtin'.registers{}<cr>
" nnoremap <silent> gr <cmd>(Telescope lsp_references)<cr>
" nnoremap <silent> gd <cmd>(Telescope lsp_definitions)<cr>
" nnoremap <silent> gy <cmd>(Telescope lsp_type_definitions)<cr>
:lua << EOF
local actions = require("telescope.actions")
require('telescope').load_extension('coc')
require("telescope").setup({
    defaults = {
       mappings = {
           i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})
EOF

:lua << EOF
local bazel = require("bazel")
vim.filetype.add({
  pattern = {
    [".*BUILD.*"] = "bzl",
  },
})
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "bzl",
    callback = function()
      vim.keymap.set("n", "gd", vim.fn.GoToBazelDefinition,
        { buffer = true, desc = "Goto Bazel Definition" })
    end,
  }
)
vim.keymap.set("n", "gbt", vim.fn.GoToBazelTarget, {desc = "Goto Bazel Build File"})
EOF
