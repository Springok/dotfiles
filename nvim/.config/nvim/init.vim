" Install Vim Plug at first setup
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.18/bin/python'
let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.6.9/bin/python'

call plug#begin()

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

"================================================
" Clojure
"================================================
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'luochen1990/rainbow'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

"================================================
" Dev Tools
"================================================
Plug 'rking/ag.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dispatch'
Plug 'bootleq/vim-qrpsqlpq'
Plug 'thinca/vim-quickrun'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-cucumber'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'majutsushi/tagbar' " list all methods in a file
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

"================================================
" Javascript/HTML
"================================================
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-ragtag'
Plug 'ap/vim-css-color'

"================================================
" Git
"================================================
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

"================================================
" Enhance Vim
"================================================
Plug 'austintaylor/vim-indentobject'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
"================================================
" Theme
"================================================
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'rakr/vim-one'
Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim'

call plug#end()

"================================================
" General
"================================================
" set clipboard=unnamed                                        " yank and paste with the system clipboard
" set directory-=.                                             " don't store swapfiles in the current directory
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set list                                                     " show trailing whitespace
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
" set colorcolumn=80

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

"================================================
" Remap
"================================================
let mapleader = ','

" sometimes need , to repeat latest f, t, F or T in opposite direction
noremap \ ,
" Helps when I want to delete something without clobbering my unnamed register.
nnoremap s "_d
nnoremap ss "_dd

" navigating
noremap H ^
noremap L $
nmap j gj
nmap k gk

noremap <C-n> <C-i>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
vnoremap <leader>ag y:AgBuffer <c-r>"<cr>

"================================================
" Plugin
"================================================
"
"
let g:ale_linters = {
\   'ruby': ['rubocop', 'ruby'],
\}

" https://github.com/dense-analysis/ale/pull/1850, make it work with bundle
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1

" Disable documentation window
set completeopt-=preview

let g:rainbow_active = 1
" default updatetime 4000ms is not good for async update signify
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

"================= Helper =================
for f in split(globpath('~/dotfiles/script/vim', '*.vim'), '\n')
  exe 'source' f
endfor

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

"================================================
" Shortcut
"================================================
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
noremap <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" fzf search
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Files app/concepts<CR>
let g:fzf_preview_window = 'right:33%'

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" indenting
noremap <leader>in mmgg=G'm

nmap <leader>p obinding.pry<ESC>^
nmap <leader>c "ay
nmap <leader>vv "ap

" window
nmap <leader>w <C-w>
nmap <leader>wf <C-w>f<C-w>H

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

" vim-gitgutter
" nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gg :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gdd :SignifyHunkDiff<CR>
nnoremap <leader>gdr :SignifyHunkUndo<CR>

" Fugitive
set diffopt+=vertical

nmap <silent><leader>gb :Gblame<cr>

nmap <leader>ge :Gedit<Space>
" nmap <leader>gdd :Gdiff<Space>
" compare with working area
nmap <leader>gdw :Gdiff<cr>
" compare with index
nmap <leader>gdi :Gdiff HEAD<cr>
" reset the diff with working area in Gdiff mode
" nmap <leader>gdr :diffget<cr>
nmap <leader>gs :Gstatus<cr>

" Rails
nmap <leader>aa :A<CR>
nmap <leader>av :AV<CR>
nmap <leader>gr :R<CR>
nmap <leader>vl :sp<cr><C-^><cr>
nmap <leader>hl :vsp<cr><C-^><cr>

" Ag
nmap <leader>ab :AgBuffer<space>
nmap <leader>ag :Ag<space>

" Vim-test
nmap <silent> <leader><C-t> :TestNearest<CR>
nmap <silent> <leader><C-f> :TestFile<CR>
nmap <silent> <leader><C-l> :TestLast<CR>

" start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
nmap <leader>l <Plug>(EasyAlign)

" Vim Tmux Runner
nnoremap <leader>ar :VtrAttachToPane<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>rc :VtrOpenRunner {'orientation': 'h', 'percentage': 45, 'cmd': 'rc'}<cr>
nnoremap <leader>ry :VtrOpenRunner {'orientation': 'h', 'percentage': 45, 'cmd': 'rpy'}<cr>

" barrow from unimpaired
nmap ]<Space> o<ESC>
nmap [<Space> O<ESC>

" run commands in vim
nmap <leader>ss :!rpu<enter>
nmap <leader>ks :!krpu<enter>
nmap <leader>cop :!cop<enter>

"================================================
" Javascript
"================================================
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx'
\  },
\}

let g:user_emmet_leader_key='<C-E>'

" work with vim-commentary
" https://github.com/tpope/vim-commentary/issues/68#issuecomment-265496851
autocmd FileType javascript.jsx setlocal commentstring=/*\ %s\ */

"================================================
" Clojure
"================================================
" a few extra mappings for fireplace
" evaluate top level form
au BufEnter *.clj nnoremap <buffer> cpt :Eval<CR>
" show last evaluation in temp file
au BufEnter *.clj nnoremap <buffer> cpl :Last<CR>

"================================================
" Theme
"================================================
set termguicolors

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" lightline
set noshowmode
set showtabline=2

colorscheme night-owl " lightline: night-owl
" colorscheme gruvbox   " lightline: gruvbox
" colorscheme one       " lightline: one
" colorscheme onedark   " lightline: onedark
" colorscheme nord      " lightline: nord
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" colorscheme ayu       " l lightline: ayu_light / ayu_mirage
" colorscheme dracula   " lightline: dracula
" colorscheme iceberg   " lightline: iceberg
set background=dark

let g:lightline = {
      \ 'colorscheme': 'nord',
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
" let g:lightline#bufferline#clickable       = 1

" change SpellBad style, have to do this after colorscheme setup, otherwise
" will be overwritten
hi SpellBad ctermbg=20

" keep set secure on the last line
set secure " safer working with script files in the current directory

" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
