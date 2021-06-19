" Install Vim Plug at first setup
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" let g:python_host_prog = $HOME . '/.asdf/installs/python/2.7.18/bin/python'
" let g:python3_host_prog = $HOME . '/.asdf/installs/python/3.6.9/bin/python'

call plug#begin()

Plug 'dstein64/vim-startuptime'

"================================================
" Enhance Vim
"================================================
Plug 'austintaylor/vim-indentobject'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'bootleq/vim-cycle'
Plug 'luochen1990/rainbow'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-projectionist'
" Plug 'chaoren/vim-wordmotion'

"================================================
" Dev Tools
"================================================
Plug 'dyng/ctrlsf.vim'
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

"================================================
" Ruby/Rails
"================================================
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

"================================================
" Clojure
"================================================
" Plug 'guns/vim-clojure-static'
" Plug 'tpope/vim-fireplace'
" Plug 'guns/vim-clojure-highlight'

" Plug 'tpope/vim-salve'

Plug 'Olical/conjure', {'tag': 'v4.2.0'}

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

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

" let g:wordmotion_mappings = {
"       \ 'w': 'gw',
"       \ 'b': 'gb',
"       \ 'e': 'ge',
"       \ 'ge': '',
"       \ 'aw': 'gaw',
"       \ 'iw': 'giw',
"       \ '<C-R><C-W>': '',
"       \ 'W': '',
"       \ 'B': '',
"       \ 'E': '',
"       \ 'gE': '',
"       \ 'aW': '',
"       \ 'iW': '',
"       \ '<C-R><C-A>': '',
"       \ }

" let g:wordmotion_spaces = '_-.'

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
autocmd BufRead,BufNewFile *.yml setlocal spell
" slim is slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
" git commit textwidth limit
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" autocmd BufNewFile,BufRead *.cljs setlocal foldmethod=syntax
" autocmd BufNewFile,BufRead *.cljs setlocal foldlevel=2

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

noremap <C-n> <C-i>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

"================================================
" Plugin
"================================================

" conjure
let g:conjure#log#hud#width = 1
let g:conjure#log#hud#anchor = "SE"

" " word means word, override the setup in vim-clojure-static
" autocmd FileType clojure setlocal iskeyword+=?,*,!,+,/,=,<,>,$
autocmd FileType clojure setlocal iskeyword-=.
autocmd FileType clojure setlocal iskeyword-=/
" autocmd FileType clojure setlocal iskeyword-=:

" CtrlSF
 let g:ctrlsf_default_view_mode = 'compact'
 let g:ctrlsf_ignore_dir = ['vendor/assets', 'public/eva/js/', 'cljs-runtime', 'node_modules']
 let g:ctrlsf_indent = 2
 let g:ctrlsf_mapping = {
       \ "split"   : "gi",
       \ "vsplit"  : "gs"
       \ }

" let g:sexp_enable_insert_mode_mappings = 0
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview
"
"
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
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fe :Files app/concepts<CR>
nnoremap <leader>fm :Files app/models<CR>
nnoremap <leader>fapi :Files app/controllers/api<CR>
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
autocmd FileType clojure nmap <buffer> <leader>p o(js/console.log<Space>
nmap <leader>p obinding.pry<ESC>^

" momeorized for multiple copy
nmap <leader>c "ay
nmap <leader>vv "ap

" use system clipboard
noremap <Leader>Y "+y
noremap <Leader>P "+p

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

" vim-signify (replace vim-gitgutter)
nnoremap <leader>gg :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gdd :SignifyHunkDiff<CR>
nnoremap <leader>gdr :SignifyHunkUndo<CR>

" Fugitive
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
nmap <leader>gs :Gstatus<cr>

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

" start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
nmap <leader>l <Plug>(EasyAlign)

" Vim Tmux Runner
nnoremap <leader>ar :VtrAttachToPane<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>rt :VtrOpenRunner {'orientation': 'v', 'percentage': 15, 'cmd': 'rtw'}<cr>

" barrow from unimpaired
nmap ]<Space> o<ESC>
nmap [<Space> O<ESC>

" run commands in vim
nmap <leader>ss :!rpu<enter>
nmap <leader>ks :!krpu<enter>
" nmap <leader>cop :!cop<enter> FIXME: need to find a way to use cop in zshenv

" bootleq cycle
nmap <silent> gs <Plug>CycleNext
vmap <silent> gs <Plug>CycleNext

"================================================
" Javascript
"================================================
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx'
\  },
\}

let g:user_emmet_leader_key='<C-E>'

"================================================
" Theme
"================================================
set termguicolors

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" lightline
set noshowmode
set showtabline=2

" colorscheme night-owl " lightline: night-owl
" colorscheme gruvbox   " lightline: gruvbox
" colorscheme one       " lightline: one
" colorscheme onedark   " lightline: onedark
" colorscheme nord      " lightline: nord
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" colorscheme ayu       " l lightline: ayu_light / ayu_mirage
colorscheme dracula   " lightline: dracula
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
