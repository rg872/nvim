set number
set nowrap
set ignorecase
set guifont=FiraCode\ Nerd\ Font\ Mono:10
set nocompatible
set hidden
set scrolloff=999
syntax enable
filetype plugin on

"Set leader key to ','
let mapleader=","

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :nohlsearch<CR><CR>

"Window Split/Move
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

"Neovim terminal settings
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <C-x> :call OpenTerminal()<CR>

"Vim-Plug
call plug#begin('~/.config/nvim/plugged')

"Core plugins
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'

"Formatting plugin
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"Fuzzy File Search
Plug 'junegunn/fzf', {'do' : { -> fzf#install() }} "install the_silver_searcher for include gitignore etc
Plug 'junegunn/fzf.vim'

"Code Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags' "install universal-ctags 'ctags.io'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'} "install universal-ctags 'ctags.io'
Plug 'ervandew/supertab'

"Visual Plugin
Plug 'itchyny/vim-gitbranch'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'sainnhe/edge'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'ryanoasis/vim-devicons'
Plug 'miyakogi/conoline.vim'
Plug 'psliwka/vim-smoothie'


"Extra plugins
Plug 'moll/vim-bbye'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'

"Unused plugins
"Plug 'tpope/vim-sleuth' "also included in vim-polyglot
"Plug 'ayu-theme/ayu-vim'
"Plug 'sainnhe/sonokai'
"Plug 'mg979/vim-visual-multi', {'branch' : 'master'}
"Plug 'rhysd/git-messenger.vim'

call plug#end()

if (has("termguicolors"))
  set termguicolors
  colorscheme edge
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_setColors = 0
endif

"NerdTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

"NerdTree keybind
nmap <silent><C-b> :NERDTreeToggle<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

"Git MerdTree
let g:NERDTreeGitStatusUserNerdFonts = 1

" editorconfig and fugitive compability
let g:EditorConfig_exclude_patterns = ['fugitive://*']

"lightline settings
let g:lightline = {
      \ 'colorscheme': 'edge',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename' : 'LightLineFileName'
      \ },
      \ 'enable': { 
      \   'tabline': 1 
      \ },
      \ }

function LightLineFileName()
  return expand('%:t') !=# '' ? expand('%') : '[No Name]'
endfunction

"vim bbye for navigation
noremap <silent><Right> :bn<CR>
noremap <silent><Left> :bp<CR>
noremap <silent><Down> :Bwipeout<CR>
noremap <silent><Up> :bufdo :Bdelete<CR>

"FZF settings
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"COC settings
let g:coc_global_extensions = [
      \'coc-emmet',
      \'coc-css',
      \'coc-html', 
      \'coc-json',
      \'coc-prettier',
      \'coc-eslint',
      \'coc-tsserver'
      \]

"Buftabline settings
let g:buftabline_indicators = 1

"conoline settings
let g:conoline_auto_enable = 1
let g:conoline_use_colorscheme_default_normal=1
let g:conoline_use_colorscheme_default_insert=1


