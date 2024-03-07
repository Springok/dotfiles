-- ==================
--      Autocmd
-- ==================
vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
    autocmd BufNewFile,BufRead *.thor,.pryrc,pryrc setlocal filetype=ruby
    autocmd BufNewFile,BufRead ssh_config,*/.ssh/config.d/*  setf sshconfig
    " https://github.com/neovim/neovim/issues/7994#issuecomment-388296360
    autocmd InsertLeave * set nopaste
    autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb
    autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell textwidth=72
    autocmd Filetype gitcommit nmap <buffer> <leader>p oSee merge request metis/nerv!
  augroup end
  augroup _yml
    autocmd!
    autocmd FileType eruby.yaml set filetype=yaml
    autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
    autocmd BufRead,BufNewFile *.yml setlocal spell
  augroup end
  augroup _auto_resize
    " automatically rebalance windows on vim resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
  augroup _clojure
    autocmd!
  " autocmd FileType clojure setlocal iskeyword+=?,*,!,+,/,=,<,>,$
    autocmd FileType clojure setlocal iskeyword-=.
    autocmd FileType clojure setlocal iskeyword-=/
    autocmd FileType clojure nmap <buffer> <leader>p i(debux.core/dbg<Space>
  augroup end
]])
