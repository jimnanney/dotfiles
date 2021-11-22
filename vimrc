"
set nocompatible
filetype off

" Section: Encoding {{{1
" ----------------------
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fenc=utf-8
"set listchars=trail:⛵
"set listchars=tab:>\ ,trail:⛵,extends:>,precedes:<,nbsp:+
"set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
"set list
" Most of this is taken from Gary Bernhardt's .vimrc
" available from here: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

" Support for ruby def end, do end etc
runtime macros/matchit.vim

" Section: Plugins {{{1
" ----------------------
set rtp+=~/.vim/bundle/Vundle.vim
"set rtp+=/usr/local/lib/python3.8/site-packages/powerline/bindings/vim
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jason0x43/vim-js-indent'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'flazz/vim-colorschemes'
Plugin 'elixir-editors/vim-elixir'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-ruby/vim-ruby'
"Plugin 'dense-analysis/ale'
call vundle#end()

" Section: Folding {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function MyFoldText()
  let length = v:foldend - v:foldstart
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  let foldtext = substitute(sub, '^\s\+\|\s\+$', '', 'g')
  return v:folddashes . "+ ". foldtext . " (" . length . " lines) +" . v:folddashes
endfunction

set foldtext=MyFoldText()
set fillchars="fold: ,diff:-"

" Section: Options {{{1
" ---------------------
" autoload plugins and indentation based on file type
filetype plugin indent on
" disable auto indent in typescript files
let g:typescript_indent_disable = 1
" set all emojis as full width unicode
set emoji
"enable syntax highlighting
syntax enable
" search for tag definitions in .gemtags as well
set tags+=.gemtags
set tags+=.git/tags
" set the unnamed register to yank to the "* register for system clipboard
set clipboard=unnamed
" use line numbers in the gutter on the left side
set number
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
" expand tabs to spaces
set expandtab
" set tabs stops to 2 characters
set tabstop=2
" overide defaults tabwidwiths when typing to 2 characters
set shiftwidth=2
set softtabstop=2
" use autoindent
set autoindent
" always display a status line
set laststatus=2
" show matching braces, brackets, and parens
set showmatch
" show the matches as you type the search pattern
set incsearch
" highlight the search pattern
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
" make the command mode : 2 lines high
set cmdheight=2
" when switching buffers use the window with the buffer open if it exists
set switchbuf=useopen
" use 5 cols for the line numbers in the gutter
set numberwidth=5
" always show the tab page line (top)
set showtabline=2
" sets the cols for a window to use, steals from other windows if this one is
" smaller
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
" don't use two spaces after sentence end when joining lines
set nojoinspaces
" this fixes the O insert taking so long
set timeout timeoutlen=1000 ttimeoutlen=100
" use modelines in files if found
set modeline
" check 3 lines for modelines
set modelines=3
" ignore the patterns when expanding file globs
set wildignore+=tmp/*,*.swp,*.zip,*.exe,*.class,*.jar,*.ear,*.war
set wildignore+=*\\node_modules\\**
" set the root search directory to first anscestor with a .git or if not found, the
" current directory
let g:ctrlp_working_path_mode='ra'
" when indexing, ignore these patterns of files / directories
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|classes$\|node_modules\|npm-packages-offline-cache\|tmp$\|pack\|pack-test$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.class$\|\.jar$\|\.ear$\|.\war$',
      \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
      \ }
" don't try to index more that 100,000 files
let g:ctrlp_max_files = 100000
" don't index deeper than 100 directories
let g:ctrlp_max_depth = 100
" if indexing takes too long, you can use the git repo ls-files to get the
" list of files to index 
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
set grepprg=git\ grep\ -nI

" Section: Autocmds {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab sts=2

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber,html.handlebars,html.moustache set ai sw=2 sts=2 et
  autocmd FileType javascript set ai sw=2 sts=2 nobomb et
  autocmd FileType javascript.jsx set ai sw=2 sts=2 nobomb et
  autocmd FileType typescript nmap <buffer> <Leader>. :call OpenTestAlternateTS()<cr>
  autocmd FileType typescript nmap <buffer> <Leader>t :call RunMochaTest()<cr>
  autocmd FileType typescript nmap <buffer> <Leader>T :call RunSingleMochaTest()<cr>
  autocmd FileType typescript nmap <buffer> <Leader>i :TsuImport<cr>
  autocmd FileType typescript nmap <buffer> <Leader>h :echo tsuquyomi#hint<cr>

  autocmd BufRead,BufNewFile {*.ts,*.tsx} setlocal filetype=typescript
  autocmd BufRead,BufNewFile *.sass setlocal filetype=sass
  autocmd BufRead,BufNewFile {Guardfile,Gemfile,Rakefile} setlocal filetype=ruby

  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Don't syntax highlight markdown because it's often wrong
  autocmd FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Section: Colors {{{1
" --------------------

set t_Co=256 " 256 colors
set background=dark
let g:solarized_termcolors = 256
let g:solarized_termtrans = 0
let g:solarized_degrade = 1
let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_italic = 0
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"

let g:jsx_ext_required = 0
"colorscheme badwolf
colorscheme railscasts
"colorscheme inori
"colorscheme rubyblue
"colorscheme solarized
"colorscheme detailed

" hi Comment ctermfg=67 ctermbg=23
"hi VimLineComment ctermfg=66 ctermbg=23

" Section: Status Line  {{{1
" --------------------------
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Section: Misc Key Maps {{{1
" ---------------------------

" Set space quote to wrap a word in quotes
nnoremap <space>" ciw"<c-r>""<esc>
nnoremap <space>' ciw'<c-r>"'<esc>

inoremap <c-h> <c-o>^<script id="<c-o>$" type="text/x-handlebars-template"><cr></script><cr><c-o>2-<c-o>$<cr>
noremap <leader>y "*y
noremap <leader>] :!ruby ~/bin/test_runner.rb<cr>

nnoremap n nzzzv
nnoremap N Nzzzv
"nnoremap J mzJ`z

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
inoremap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>

" Section: Tab Key Handling {{{1
" ------------------------------
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Section: Arrow Keys {{{1
" ------------------------
" Make as no operation - retrain fingers to use hjkl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


" Section: Opening Files {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%


" Section: FileJumps {{{1
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction

nnoremap <leader>; :CtrlPTag<cr>
noremap <leader>gR :call ShowRoutes()<cr>
noremap <leader>gv :CtrlP app/views<cr>
noremap <leader>gc :CtrlP app/controllers<cr>
noremap <leader>gm :CtrlP app/models<cr>
noremap <leader>gh :CtrlP app/helpers<cr>
noremap <leader>gl :CtrlP lib<cr>
noremap <leader>gp :CtrlP public<cr>
noremap <leader>gs :CtrlP app/services<cr>
noremap <leader>gf :CtrlP features<cr>
noremap <leader>gg :topleft 100 :split Gemfile<cr>
noremap <leader>F :CtrlP %%<cr>

" Section: Switch between test and production code {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternateTS()
    let new_file = AlternateForCurrentTSFile()
    exec ':e ' . new_file
endfunction

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentTSFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^app/javascript/test') != -1
  let going_to_spec = !in_spec
  if going_to_spec
    let new_file = substitute(new_file, '^app/javascript/src/\(.*\).\(ts[x]\?\)$', 'app/javascript/test/\1Test.\2','')
  else
    let new_file = substitute(new_file, '^app/javascript/test/\(.*\)Test.\(ts[x]\?\)$', 'app/javascript/src/\1.\2','')
  endif
  return new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '\(^spec/\|^test/\)') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') || match(current_file, '\<helpers\>') != -1
  let using_rspec = filereadable("spec/spec_helper.rb")
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^lib/', '', '')
    end

    if using_rspec
      let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
      let new_file = 'spec/' . new_file
    else
      let new_file = substitute(new_file, '\.rb$', '_test.rb', '')
      let new_file = 'test/' . new_file
    end
  else
    if using_rspec
      let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
      let new_file = substitute(new_file, '^spec/', '', '')
    else
      let new_file = substitute(new_file, '_test\.rb$', '.rb', '')
      let new_file = substitute(new_file, '^test/', '', '')
    end

    if in_app
      let new_file = 'lib/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>

" Section: Running Tests {{{1
" ------------------------
noremap <leader>t :call RunTestFile()<cr>
noremap <leader>T :call RunNearestTest()<cr>
noremap <leader>a :call RunTests('')<cr>
noremap <leader>c :w\|:!script/features<cr>
noremap <leader>w :w\|:!script/features --profile wip<cr>
noremap <leader>u :!ruby %

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    if filereadable("spec/spec_helper.rb")
      let opts = " -b"
    else
      let opts = ""
    end
    call RunTestFile(":" . spec_line_number . opts)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if match(a:filename, '\feature_spec.rb$') != -1
      let skip_pack = ""
    else
      let skip_pack = "SKIP_WEBPACKER=true "
    endif
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
          if filereadable("spec/spec_helper.rb")
            exec ":!" . skip_pack . "SHOW_CHROME=true bundle exec rspec --color " . a:filename
          else
            exec ":!" . skip_pack . "SHOW_CHROME=true HEADLESS=false bundle exec rails test " . a:filename
          end
        else
            exec ":!" . skip_pack . "rspec --color " . a:filename
        end
    end
endfunction

function! RunMochaTest()
  let current_file = expand('%')
  let not_in_spec = match(current_file, '^app/javascript/test') == -1
  if not_in_spec
    let current_file = './' . shellescape(AlternateForCurrentTSFile())
  endif
  exec '!export NODE_ENV=test; export TZ=America/New_York; yarn run mocha --opts ./app/javascript/test/mocha.opts ' . current_file
endfunction

function! RunSingleMochaTest()
  let current_file = expand('%')
  let not_in_spec = match(current_file, '^app/javascript/test/') == -1
  if not_in_spec
    if exists("s:lastsingletestrun")
      exec s:lastsingletestrun
    endif
    return
  endif
  let position = line('.')
  let lastjumppos = line('.')
  let desc = ""
  while 1
    keepjumps normal! [{
    if line('.') == lastjumppos
      break
    endif
    let lastjumppos = line('.')
    let matches = matchlist(getline('.'), '\(describe\|it\|context\)\s*(\s*[''"]\(.*\)[''"\]\s*,')
    if len(matches[2]) > 0
      if len(desc) > 0
        let desc = ' ' . desc
      endif
      let desc = matches[2] . desc
    endif
  endwhile
  exec 'keepjumps normal! ' . position . 'G'
  let current_file = "./" . shellescape(current_file)
  let args = ' -g "' . shellescape(desc, 1) . '"'
  let s:lastsingletestrun = ':!export NODE_ENV=test; export TZ=America/New_York; yarn run mocha --opts ./app/javascript/test/mocha.opts ' .current_file . ' -g ' . shellescape(desc, 1)
  exec s:lastsingletestrun
endfunction

" Section: MD5 {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

" Function: RenameFile - Rename Current File {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Function: PromoteToLet - Promote Variable to RSpec let {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  let position = line('.')
  let results = FindBlock()
  if results == -1
    :keepjumps normal! dd
    :call search('describe\|context', 'b')
    :keepjumps normal! p
    :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    :keepjumps normal ==
    exec 'keepjumps normal! ' . position . 'G'
  else
    let @a = 'let(:'
    keepjumps normal! 0wvaw"Axdw
    let @a .= ") do\n"
    exec 'keepjumps normal! V' . results . 'G"Ax'
    let @a .= "end\n"
    call search('describe\|context', 'b')
    exec 'keepjumps normal! "agp'
    :keepjumps normal! k%V%=
  endif
endfunction
:command! PromoteToLet :call PromoteToLet()
:noremap <leader>p :PromoteToLet<cr>

" Function: ExtractVariable {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

" Function: InlineVariable {{{1
" ------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction
nnoremap <leader>ri :call InlineVariable()<cr>

function! ExtractMethod()
  normal "ay
  let pattern = @a

endfunction

" Command: OpenChangedFiles - Open a split for each dirty file in git {{{1
" ------------------------
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

" Command: InsertTime - Insert the current time {{{1
" ------------------------
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
command! ConvertTime :normal vi'yci'<c-r>=strftime('%s', <c-r>p)

set makeprg=ant\ \-f\ ~/paths.xml\ test
set errorformat=\ %#[%.%#]\ %#%f:%l:%v:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
    \%A\ %#[%.%#]\ %f:%l:\ %m,%-Z\ %[#[%.%#]\ %p^,%C\ %#[%.%#]\ %#%m
" vim:fdm=marker fen ts=2 sts=2 sw=2 et 
" Command: Incr - Increment a column of like numbers {{{1
" DESCRIPTION:   Given a column of the same number increment each row based on
"                the original number.
" EXAMPLE USAGE: Assuming we have the following column of numbers.
"                1
"                1
"                1
"                1
"                Visually select the numbers and then press <C-n> and the
"                numbers will be incremented to the following
"                1
"                2
"                3
"                4
"===============================================================================
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction

function! RunMochaTest()
  let current_file = expand('%%')
  let not_in_spec = match(current_file, '^app/javascript/test/') == -1
  if not_in_spec
    let current_file = AlternateForTSFile()
  endif
  echom '!yarn run mocha ' . current_file
endfunction

function! RunSingleMochaTest()
  let not_in_spec = match(current_file, '^app/javascript/test/') == -1
  if not_in_spec
    if exists(s:lasttestrun)
      echom "re-running last test"
      echom s:lastsingletestrun
    endif
    return
  endif
  let position = line('.')
  let lastjumppos = line('.')
  let desc = ""
  while 1
    keepjumps normal! [{
    if line('.') == lastjumppos
      break
    endif
    let lastjumppos = line('.')
    let matches = matchlist(getline('.'),'\(describe\|it\)\s*(\s*[''"]\(.*\)[''"]\s*,')
    if len(matches[2]) > 0
      if len(desc) > 0
        let desc = ' ' . desc
      endif
      let desc = matches[2] . desc
    endif
  endwhile
  execute 'keepjumps normal! '.position.'G' 
  let s:lastsingletestrun = '!yarn run mocha '.expand('%%') . ' -g "' . desc . '"'
  echom s:lastsingletestrun
endfunction

function! OpenTestAlternateTS()
  let new_file = AlternateForCurrentTSFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentTSFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^app/javascript/test/') != -1
  let going_to_spec = !in_spec
  if going_to_spec
    let new_file = substitute(new_file, '^app/javascript/src/\(.*\).\(ts[x]\?\)$', 'app/javascript/test/\1Test.\2', '')
  else
    let new_file = substitute(new_file, '^app/javascript/test/\(.*\)Test.\(ts[x]\?\)', 'app/javascript/src/\1.\2', '')
  endif
  return new_file
endfunction
"===============================================================================
" Function Keymappings
"===============================================================================
vnoremap <C-n> :call Incr()<CR>

" javascript conceals
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
"let g:javascript_conceal_noarg_arrow_function = "🞅"
"let g:javascript_conceal_underscore_arrow_function = "🞅"

abbr thier their
abbr recieve receive
abbr reciept receipt

hi Special                   guifg=#2a71dc ctermfg=32

