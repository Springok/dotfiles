" test current file use shortcut
if has('vim_starting')
  if executable('w')
    " let result = system("w --no-header --short | wc -l")
    " if str2nr(result) > 1
    if 1
      autocmd User Rails call s:rails_test_helpers_for_pair()

      function! s:rails_test_helpers_for_pair() "{{{
        let type = rails#buffer().type_name()
        let relative = rails#buffer().relative()
        if type =~ '^test' || (type == 'javascript-coffee' && relative =~ '^test/')
          nmap <leader>t [rtest]
          nnoremap <silent> [rtest]l :call <SID>rails_test_tmux('h', 'false')<CR>
          nnoremap <silent> [rtest]w :call <SID>rails_test_tmux('new-window', 'false')<CR>
          nnoremap <silent> [rtest]. :call <SID>rails_test_tmux('last', 'false')<CR>
          nnoremap <silent> [rtest]f :call <SID>rails_test_tmux('h', 'true')<CR>
        end
      endfunction "}}}
    endif
  endif
endif

function! s:rails_test_tmux(method, test_whole_file) "{{{
  let [it, path] = ['', '']

  let rails_type = rails#buffer().type_name()
  let rails_relative = rails#buffer().relative()

  if rails_type =~ '^test'
    let it = matchstr(
          \   getline(
          \     search('^\s*it\s\+\(\)', 'bcnW')
          \   ),
          \   'it\s*[''"]\zs.*\ze[''"]'
          \ )
    let path = rails_relative
  elseif rails_type == 'javascript-coffee' && rails_relative =~ '^test/'
    " Currently, teaspoon can't filter specs without 'describe' title
    " https://github.com/modeset/teaspoon/issues/304
    let desc = matchstr(
          \   getline(
          \     search('^\s*describe\s*\(\)', 'bcnW')
          \   ),
          \   'describe\s*[''"]\zs.*\ze[''"]'
          \ )
    let it = matchstr(
          \   getline(
          \     search('^\s*it\s\+\(\)', 'bcnW')
          \   ),
          \   'it\s*[''"]\zs.*\ze[''"]'
          \ )
    let it = (empty(desc) || empty(it)) ?
          \ '' :
          \ join([desc, it], ' ')
    let path = rails_relative
  end

  if empty(it) || empty(path)
    let it   = get(s:, 'rails_test_tmux_last_it', '')
    let path = get(s:, 'rails_test_tmux_last_path', '')
  end

  if empty(it) || empty(path)
    echohl WarningMsg | echomsg 'No `it` block found' | echohl None
    return
  end

  let s:rails_test_tmux_last_it = it
  let s:rails_test_tmux_last_path = path

  if rails_type == 'javascript-coffee'
    " https://github.com/modeset/teaspoon/wiki/Teaspoon-Configuration
    " TODO add back `--filter` if I can handle nested `describe` blocks
    " let test_command = printf('RAILS_RELATIVE_URL_ROOT= teaspoon %s --fail-fast -f pride --filter %s', path, shellescape(it))
    let test_command = printf('FAIL_FAST=true FORMATTERS=documentation rake teaspoon files=%s', path)
    let title = '☕️'
  elseif rails_type == 'test-integration'
    " TODO why can't just use ruby -Itest?
    let test_command = printf('disboot RAILS_RELATIVE_URL_ROOT= bundle exec rake test:integration TEST=%s', path)
    let title = matchstr(rails_type, '\vtest-\zs.{4}')
  else
    if a:test_whole_file == 'true'
      let test_command = printf('disboot bundle exec ruby -Itest %s', path)
    else
      let test_command = printf('disboot bundle exec ruby -Itest %s --name /%s/', path, shellescape(escape(it, '()[]?')))
    endif

    let type_short = matchstr(rails_type, '\vtest-\zs.{4}')

    if type_short == 'unit'
      let title = type_short
    elseif type_short == 'func'
      let title = type_short
    else
      let title = type_short
    endif
  endif

  call TmuxNewWindow({
        \   "text": test_command,
        \   "title": '∫ ' . title,
        \   "directory": get(b:, 'rails_root', getcwd()),
        \   "remember_pane": 1,
        \   "method": a:method
        \ })
endfunction "}}}

function! TmuxNewWindow(...) "{{{
  let options = a:0 ? a:1 : {}
  let text = get(options, 'text', '')
  let title = get(options, 'title', '')
  let directory = get(options, 'directory', getcwd())
  let method = get(options, 'method', 'new-window')
  let size = get(options, 'size', '20')
  let remember_pane = get(options, 'remember_pane', 0)
  let pane = ''

  if method == 'last'
    if !exists('s:last_tmux_pane') || empty(s:last_tmux_pane)
      echohl WarningMsg | echomsg "Can't find last tmux pane. Continue with 'new-window'." | echohl None
      let method = 'new-window'
    else
      " if system(printf('tmux list-pane -s -F "#{pane_id}" | egrep %%%s$', s:last_tmux_pane) =~ '%'
      "   let pane = s:last_tmux_pane
      " else
      "   echohl WarningMsg | echomsg "Can't find last tmux pane. Continue with 'new-window'." | echohl None
      "   let method = 'new-window'
      " endif
      let pane = s:last_tmux_pane
    endif
  elseif method == 'quit'
    if !exists('s:last_tmux_pane') || empty(s:last_tmux_pane)
      echohl WarningMsg | echomsg "Can't find last used pane." | echohl None
      return
    else
      call system('tmux kill-pane -t ' . matchstr(s:last_tmux_pane, '%\d\+'))
      unlet! s:last_tmux_pane
      return
    endif
  endif

  if empty(pane) && method != 'new-window'
    " use splitted pane if available
    let pane = matchstr(
          \   system('tmux list-pane -F "#{window_id}#{pane_id}:#{pane_active}" | egrep 0$'),
          \   '\zs@\d\+%\d\+\ze'
          \ )
  endif

  if empty(pane)
    if method == 'new-window'
      let cmd = 'tmux new-window -a '
            \ . (empty(title) ? '' : printf('-n %s', shellescape(title)))
            \ . printf(' -c %s', shellescape(directory))
    elseif method == 'v'
      let cmd = 'tmux split-window -d -v '
            \ . printf('-p %s -c %s ', size, shellescape(directory))
    elseif method == 'h'
      let cmd = 'tmux split-window -d -h '
            \ . printf(' -c %s ', shellescape(directory))
    endif

    let pane = substitute(
          \   system(cmd . ' -P -F "#{window_id}#{pane_id}"'), '\n$', '', ''
          \ )
  endif

  if remember_pane
    let s:last_tmux_pane = pane
  endif

  let window_id = matchstr(pane, '@\d\+')
  let pane_id = matchstr(pane, '%\d\+')

  if !empty(text)
    let cmd = printf(
          \   'tmux set-buffer %s \; paste-buffer -t %s -d \; send-keys -t %s Enter',
          \   shellescape(text),
          \   pane_id,
          \   pane_id
          \ )
    sleep 300m
    call system('tmux select-window -t ' . window_id)
    call system(cmd)
  endif
endfunction "}}}
