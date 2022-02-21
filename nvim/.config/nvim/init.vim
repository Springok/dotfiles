call plug#begin()
"================================================
" Enhance Vim
"================================================
Plug 'austintaylor/vim-indentobject'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
" Plug 'RRethy/nvim-treesitter-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'bootleq/vim-cycle'

Plug 'ssh://git@gitlab.abagile.com:7788/chiao.chuang/vim-abagile.git'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'

"================================================
" Dev Tools
"================================================
Plug 'dyng/ctrlsf.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dispatch'
Plug 'bootleq/vim-qrpsqlpq'
Plug 'thinca/vim-quickrun', {'commit': 'c980977f1d77b3285937b9d7b5baa964fc9ed7f5'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'majutsushi/tagbar'

" Plug 'janko-m/vim-test'

"================================================
" Autocomplete
"================================================
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"================================================
" Javascript/HTML
"================================================
Plug 'kchmck/vim-coffee-script'
" Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-ragtag'
Plug 'ap/vim-css-color'

"================================================
" Git
"================================================
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

"================================================
" Theme
"================================================
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'Mofiqul/vscode.nvim', { 'branch': 'main' }
Plug 'joshdick/onedark.vim', { 'branch': 'main' }

"================================================
" Ruby/Rails
"================================================
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

"================================================
" Clojure
"================================================
Plug 'luochen1990/rainbow'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-fireplace' " Navigating and Comprehending
Plug 'clojure-vim/clojure.vim'

Plug 'Olical/conjure'
Plug 'clojure-vim/vim-jack-in'

call plug#end()

"================================================
" General
"================================================
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set number                                                   " show line numbers
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full
set nowrap
set nocursorline
set nohlsearch
set relativenumber
set noswapfile                                               " disable .swp files creation in vim
set hidden                                                   " allow you to switch between buffers without saving
set splitright

" set colorcolumn=80
"
syntax on
filetype plugin indent on

au BufNewFile,BufRead ssh_config,*/.ssh/config.d/*  setf sshconfig

" https://github.com/neovim/neovim/issues/7994#issuecomment-388296360
au InsertLeave * set nopaste

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
autocmd BufRead,BufNewFile *.yml setlocal spell

" slim is slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" git commit textwidth limit
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" autocmd FileType clojure setlocal iskeyword+=?,*,!,+,/,=,<,>,$
autocmd FileType clojure setlocal iskeyword-=.
autocmd FileType clojure setlocal iskeyword-=/

"================================================
" Remap
"================================================
let mapleader = ','

" sometimes need, to repeat latest f, t, F or T in opposite direction
noremap \ ,

" Helps when I want to delete something without clobbering my unnamed register.
nnoremap s "_d
nnoremap ss "_dd

" navigating
noremap H ^
noremap L $
nmap j gj
nmap k gk
nnoremap ,gv V`]

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

noremap <C-n> <C-i>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

nnoremap Y yg_

" moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"================================================
" Plugin
"================================================

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})

" Disable documentation window
set completeopt-=preview

" rainbow
let g:rainbow_active = 1

" CtrlSF
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_ignore_dir = ['vendor/assets', 'public/eva/js/', 'cljs-runtime', 'node_modules', 'db']
let g:ctrlsf_indent = 2
let g:ctrlsf_mapping = {
\ "split"   : "gi",
\ "vsplit"  : "gs"
\ }

" Ale =========
let g:ale_linters = {
\   'ruby': ['rubocop', 'ruby'],
\   'clojure': ['clj-kondo'],
\}

" https://github.com/dense-analysis/ale/pull/1850, make it work with bundle
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1

" signify: default updatetime 4000ms is not good for async update signify
set updatetime=100

" extra rails.vim help
autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb

" NerdTree Setting
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDSpaceDelims=1

" Vim-test
" https://github.com/janko-m/vim-test#custom-strategies
" let test#strategy = "vtr"
let test#ruby#minitest#options = '--verbose'

" vim-easy-align
" override default ignore comment and string in vim-easy-align
let g:easy_align_ignore_groups = []

" run sql file to give your the result table!
" usage: <leader_key>p + j, l, r
function! s:init_qrpsqlpq()
  nmap <buffer> <Leader>p [qrpsqlpq]
  nnoremap <silent> <buffer> [qrpsqlpq]j :call qrpsqlpq#run('split')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]l :call qrpsqlpq#run('vsplit')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]r :call qrpsqlpq#run()<CR>

  if !exists('b:rails_root')
    call RailsDetect()
  endif
  if !exists('b:rails_root')
    let b:qrpsqlpq_db_name = 'postgres'
  endif
endfunction

if executable('psql')
  let g:qrpsqlpq_expanded_format_max_lines = -1
  autocmd FileType sql call s:init_qrpsqlpq()
endif

" Conjure
let g:conjure#log#hud#width = 0.7
let g:conjure#log#hud#height = 0.7
let g:conjure#log#hud#anchor = "SE"
let g:conjure#highlight#enable = 'true'
" let g:conjure#mapping#prefix = ",c"
let g:conjure#log#botright = 'true'
nnoremap ,ccs :ConjureShadowSelect app<CR>

"================================================
" Shortcut
"================================================
nnoremap <leader>dd :NERDTreeToggle<CR>
nnoremap <leader>df :NERDTreeFind<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call abagile#whitespace#strip_trailing()<CR>
noremap <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" fzf search
" https://github.com/junegunn/fzf.vim#commands
nnoremap <C-p> :GFiles<CR>
" nnoremap <C-p> :Files <C-R>=expand('%:h')<CR><CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :Files<CR>
let g:fzf_preview_window = 'right:30%'
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

" let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'

command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" CtrlSF search (replace ag.vim)
nmap     <leader>ff <Plug>CtrlSFPrompt
nmap     <leader>fc <Plug>CtrlSFCwordExec
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fp <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>
inoremap <leader>ft <Esc>:CtrlSFToggle<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" indenting
noremap <leader>in mmgg=G'm

" Insert Debugger
autocmd FileType clojure nmap <buffer> <leader>p o(prn<Space>
autocmd Filetype gitcommit nmap <buffer> <leader>p oSee merge request metis/nerv!
nmap <leader>p obinding.pry<ESC>^

" momeorized for multiple copy
" nmap <leader>c "ay
" nmap <leader>vv "ap

" use system clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>P "+p
nnoremap <Leader>y "+y

" window
nmap <leader>w <C-w>
nmap <leader>wf <C-w>f<C-w>H
" nnoremap <Leader>+ :vertical resize +10<CR>
" nnoremap <Leader>- :vertical resize -10<CR>

" buffer switch
nnoremap <silent> <tab> :bn<CR>
nnoremap <silent> <S-tab> :bp<CR>

" Note that remapping C-s requires flow control to be disabled (in .zshrc)
nmap <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Close current buffer
nmap <leader>q <esc>:bw<cr>
imap <leader>q <esc>:bw<cr>

" in all modes hit ,, can return to normal mode
noremap  ,, <C-\><C-N>
noremap!  ,, <C-\><C-N>

" vim-signify (replace vim-gitgutter)
nnoremap <leader>gg :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gdd :SignifyHunkDiff<CR>
nnoremap <leader>gu :SignifyHunkUndo<CR>

" fugitive
set diffopt+=vertical

nmap <silent><leader>gb :Git blame<cr>

nmap <leader>ge :Gedit<Space>
" nmap <leader>gdd :Gdiff<Space>
" compare with working area
nmap <leader>gdw :Gdiff<cr>
" compare with index
nmap <leader>gdi :Gdiff HEAD<cr>
" reset the diff with working area in Gdiff mode
" nmap <leader>gdr :diffget<cr>
nmap <leader>gs :Git<cr>

" Rails
nmap <leader>aa :A<CR>
nmap <leader>av :AV<CR>
nmap <leader>gr :R<CR>
nmap <leader>vl :sp<cr><C-^><cr>
nmap <leader>hl :vsp<cr><C-^><cr>

" Vim-test
" nmap <silent> <leader><C-t> :TestNearest<CR>
" nmap <silent> <leader><C-f> :TestFile<CR>
" nmap <silent> <leader><C-l> :TestLast<CR>

" abagile-test
nnoremap <silent> <Leader>tl :call abagile#rails#test_tmux('h')
nnoremap <silent> <Leader>tf :call abagile#rails#test_tmux('h', 1)

" start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
nmap <leader>l <Plug>(EasyAlign)

" Vim Tmux Navigator
let g:tmux_navigator_disable_when_zoomed = 1

" Vim Tmux Runner
nnoremap <leader>ar :VtrAttachToPane<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>rt :VtrOpenRunner {'orientation': 'v', 'percentage': 15, 'cmd': 'rtw'}<cr>

" run commands in vim
nmap <leader>ss :!rpu<enter>
nmap <leader>ks :!krpu<enter>
" nmap <leader>cop :!cop<enter> FIXME: need to find a way to use cop in zshenv

" vim-cycle
nmap <silent> gs <Plug>CycleNext
vmap <silent> gs <Plug>CycleNext

" vim.abagile
let g:abagile_migrant_structure_fold = 1

"================================================
" Theme
"================================================
set termguicolors

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" lightline
set noshowmode
set showtabline=2

" let g:vscode_style = "dark"
" colorscheme vscode

colorscheme onedark

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [''] ]
      \ },
      \ 'component_raw': {
      \   'buffers': 1
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

let g:lightline#bufferline#show_number     = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unnamed         = '[No Name]'

" change SpellBad style, have to do this after colorscheme setup, otherwise will be overwritten
hi SpellBad ctermbg=20

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "ruby" },
  }
}

vim.opt.list = true

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
EOF

function! s:case_tx_subs_camel(w) "{{{
  let w = substitute(a:w, '-', '_', 'g')
  return substitute(w, '_\([a-z]\)', '\u\1', 'g')
endfunction "}}}

function! s:case_tx_subs_kekab(w) "{{{
  let w = s:case_tx_subs_snake(a:w)
  return tr(w, '_', '-')
endfunction "}}}

function! s:case_tx_subs_snake(w) "{{{
  let w = substitute(a:w, '-', '_', 'g')
  return substitute(w, '\C[A-Z]', '_\L\0', 'g')
endfunction "}}}

let s:case_tx_patterns = {
      \ 'snake': '_',
      \ 'kekab': '-',
      \ 'camel': '\C[a-z][A-Z]',
      \ }

function! WordTransform()
  let save_isk = &l:iskeyword
  let cases = get(b:, 'case_tx_cases', ['snake', 'camel'])

  try
    let &l:isk = '@,48-57,-,_'
    let w = expand("<cword>")
    let x = ''
    let c = strpart(getline('.'), col('.') - 1, 1)

    for [k, pattern] in items(s:case_tx_patterns)
      if match(w, pattern) > -1
        let next_k = get(repeat(cases, 2), index(cases, k) + 1)
        let x = call(function('s:case_tx_subs_' . next_k), [w])
        silent! call repeat#set(',x') " must match your mapping to WordTransform()
        break
      end
    endfor

    if x == w || empty(x)
      echohl WarningMsg | echomsg "Nothing to transform." | echohl None
      return
    endif

    if match(w, c) < 0   " cursor might sit before keyword
      execute "normal! f" . strpart(w, 0, 1)
      execute "normal! \"_ciw\<C-R>=x\<CR>"
    else
      execute "normal! \"_ciw\<C-R>=x\<CR>"
    endif
  finally
    let &l:isk = save_isk
  endtry
endfunction

let b:case_tx_cases = ['snake', 'kekab', 'camel']
nnoremap <silent> <LocalLeader>x :call WordTransform()<CR>

" keep set secure on the last line
set secure " safer working with script files in the current directory
