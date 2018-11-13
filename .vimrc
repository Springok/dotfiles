"================================================
" Vundle
"================================================
" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle bundles
source ~/.vimrc.bundles

call vundle#end()
" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

"================================================
" General
"================================================
set nocompatible
syntax enable

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set nowrap
set nocursorline
set relativenumber
set noswapfile                                               " disable .swp files creation in vim
set hidden                                                   " allow you to switch between buffers without saving
set noesckeys                                                " Faster escape
" set colorcolumn=80

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" fix the problem on lagging issue on using relativenumber (syntax highlight)
" ref: vim/vim#282
"      vim-ruby/vim-ruby#243
set regexpengine=1
" set lazyredraw
packadd! matchit

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
autocmd BufRead,BufNewFile *.yml setlocal spell
" md is markdown
autocmd BufRead,BufNewFile *.md setlocal spell filetype=markdown
" slim is slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
" git commit textwidth limit
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" AutoComplete, not working don't why
" set omnifunc=rubycomplete#Complete
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

"================================================
" Remap
"================================================
let mapleader = ','

" sometimes need , to repeat latest f, t, F or T in opposite direction
noremap \ ,

" navigating
noremap H ^
noremap L $
" noremap 0 $
" noremap g0 g$
nmap j gj
nmap k gk

noremap <C-n> <C-i>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
vnoremap <leader>gp y:Ag <c-r>"<cr>

"================================================
" Plugin
"================================================
let g:ctrlp_match_window = 'order:ttb,max:20'
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --ignore db/ --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Reduce the time that signs appear when enable gitgutter
set updatetime=200

" extra rails.vim help
autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb

" NerdTree Setting
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDSpaceDelims=1

" Vim-test
" https://github.com/janko-m/vim-test#custom-strategies
" let test#strategy = "vtr"
" need to setup this to make binding.pry works...
" let g:test#ruby#minitest#executable = 'disboot bundle exec ruby -Itest'
" let test#ruby#minitest#options = '--verbose'

" vim-easy-align
" override default ignore comment and string in vim-easy-align
let g:easy_align_ignore_groups = []

"================= Helper =================
source ~/dotfiles/.vim/minitest_helper.vim
source ~/dotfiles/.vim/whitespace.vim

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
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" indenting
noremap <leader>i mmgg=G'm

" Move up and down by visible lines if current line is wrapped
nmap <leader>p obinding.pry<ESC>^
nmap <leader>c "ay
nmap <leader>v "ap

nmap <leader>w <C-w>
" nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
" zoom a vim pane, <C-w>= to re-balance
" nnoremap <leader>= :wincmd =<cr>

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

" hit jj back to normal mode from insert mode
" inoremap jj <ESC>

" vim-gitgutter
nnoremap <leader>gg :GitGutterToggle<CR>

" Fugitive
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gb :Gblame<cr>
" compare with working area
nmap <leader>gdw :Gdiff<cr>
" compare with index
nmap <leader>gdi :Gdiff HEAD<cr>
" reset the diff with working area
nmap <leader>gdr :diffget<cr>
nmap <leader>gs :Gstatus<cr>

" Rails
nmap <leader>aa :A<CR>
nmap <leader>av :AV<CR>
nmap <leader>gr :R<CR>
nmap <leader>vl :sp<cr><C-^><cr>

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
" nnoremap <leader>sc :VtrSendCommandToRunner<cr>
" nnoremap <leader>or :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<cr>
" nnoremap <leader>cc :VtrFlushCommand<cr>

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

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npx eslint'
"================================================
" Theme
"================================================
" Dracula
" cause error when fireup vim with `vi`
" let g:dracula_italic = 0
" let g:dracula_colorterm = 0
" colorscheme dracula
" let g:airline_theme='dracula'

" let g:airline_theme='iceberg'
" colorscheme iceberg

" colorscheme materialtheme
"
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark
let g:airline_theme='onedark'

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" vim-airline
" smart tab line, automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep         = '⮀'
let g:airline_left_alt_sep     = '⮁'
let g:airline_right_sep        = '⮂'
let g:airline_right_alt_sep    = '⮃'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch   = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr   = '⭡'

" let g:unite_source_history_yank_enable = 1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])

" keep set secure on the last line
set secure " safer working with script files in the current directory
