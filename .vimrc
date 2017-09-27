" vim-plug (https://github.com/junegunn/vim-plug) settings 
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" So long vundle, we shall now use plug since yarn
" showed me the power of parallel package installation
call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'gregsexton/MatchTag'
Plug 'lebibin/dracula-vim'
Plug 'lilydjwg/colorizer'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'posva/vim-vue'
Plug 'ryanoasis/vim-devicons'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/nginx.vim'
Plug 'vim-syntastic/syntastic'
Plug 'wakatime/vim-wakatime'
Plug 'prettier/vim-prettier'
Plug 'sekel/vim-vue-syntastic'
Plug 'posva/vim-vue'

" Initialize plugin system
call plug#end()

" Use Vim settings, rather than Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
filetype off

set encoding=utf8

set autowrite
set autoread
set history=50
set laststatus=2  " Always display status line
set linespace=2
set nobackup
set nowritebackup
set noswapfile
set ruler         " Show the cursor position all the time
set showcmd       " Display incomplete commands

" Let's enable folding!
set foldenable
set foldmethod=syntax
set foldlevel=1

" Softabs, 2 spaces for Ruby <3
set backspace=2   " Backspace deletes like most programs in insert mode
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set smartindent

" Use system clipboard
if $TMUX == ''
  set clipboard+=unnamed
endif

" Fileformat
set fileformat=unix
set fileformats=unix,dos

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Disable the mouse
set mouse=c

" Make it obvious where 80 characters is,
" since a line should not contain more than that
set textwidth=80
set colorcolumn=+1

" Numbers
" http://ideasintosoftware.com/vim-productivity-tips/
set number
set numberwidth=5
set relativenumber
nnoremap <C-n> :set nu!<CR>:set rnu!<CR>

" Splits and windows
set splitbelow
set splitright

" Enable spell check
set spell

" Showing syntax highlight group in statusline
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

filetype plugin indent on
syntax on

" UI Settings
set wildmenu
set t_Co=256
set background=dark
colorscheme dracula
let g:dracula_italic = 1
let g:airline_theme = 'dracula'

" May the force be with you
nnoremap <silent> <Left> :bprev<CR>
nnoremap <silent> <Right> :bnext<CR>
nnoremap <Up> :echo "Use k"<CR>
nnoremap <Down> :echo "Use j"<CR>

" pangloss vim-js configuration
let g:javascript_plugin_jsdoc = 1
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
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
set conceallevel=1

" https://jaxbot.me/articles/setting-up-vim-for-react-js-jsx-02-03-2015
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['mri', 'reek', 'rubocop']
let g:syntastic_scss_checkers = ['scss_lint']

" Override certain sections of airline
call airline#parts#define_function('syntaxitem','SyntaxItem')
function! AirlineInit()
  let g:airline_section_x = airline#section#create(['syntaxitem',' ','tagbar','filetype'])
endfunction
autocmd VimEnter * call AirlineInit()
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1


" Add mapping for tagbar
nmap <F8> :TagbarToggle<CR>

set lazyredraw

" http://ideasintosoftware.com/history-is-a-tree/
set undofile
set undodir=~/.vim/undodir

" For startify - htps://github.com/mhinz/vim-startify
set viminfo='100,n$HOME/.vim/files/info/viminfo'
let g:startify_list_order = [
      \ ['   MRU'],           'files' ,
      \ ['   MRU '.getcwd()], 'dir',
      \ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ 'bundle/.*/doc',
      \ ]

let g:startify_change_to_dir          = 0
let g:startify_enable_special         = 0
let g:startify_files_number           = 8
let g:startify_session_autoload       = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence    = 1
let g:startify_update_oldfiles        = 1
let g:startify_use_env                = 1

let g:startify_custom_header = [
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄▄▄█▀▀▀▀▀▀▄▄▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄█▀▀░░░░░░░░░░░▀▀█▄▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄█▀░░░░░░▄▄▄░░░░░░░░▄▀█▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░▀▀▄░░░░▄▀▀░░░█▄░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░▄█▀▀▀█▄░▄█▀▀▀█▄░▀▄░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░██░▀░██░██░▀░██░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░▀█████▀░▀█████▀░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░▄░░░░█░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░██▀▀▀▀█░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░█░▄▀▄▄▄▀░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░▄█▀▀▀▀▄░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░█▄░░░░░░░░░░░░░░█▄█▄█▄█░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░█▄░░░░░░░░░░░░▄▀█████▀░░░░▄▀░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░▄█▄░░░░░░░░░░░░░░░░░░░░░▄█▀░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░▄█▀▄░░▀▄▄░░▄▄░░░░░░░▀▀▀▄▄▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░▀░░░▀▄░░░▀▀▀██▄▄▄▄▄▄█▀▀░░░░▄▄░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█░░░░░░░▄█▀▄░▄▄▄░░░░▀██▀░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█▄░░░░▄█▄▄▄█████▄▄▄▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▀▀▀█▀▀▀▀▀░▀██▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░    Y  U   NO   VIM??   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \"░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
      \""
      \]

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Detect weird files' language
au BufNewFile,BufRead *.xlsx.axlsx set filetype=ruby
au BufNewFile,BufRead *Fastfile set filetype=ruby
au BufNewFile,BufRead *Appfile set filetype=ruby
au BufNewFile,BufRead *BUCK set filetype=python

" http://www.devinrm.com/2016/02/16/ditching-ctrl-p/
" Fuzzy-find with fzf
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>

" Customize fzf
let g:fzf_layout = { 'down': '~19%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" http://stackoverflow.com/a/2559262
set scrolloff=3         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set title               " show file in titlebar
set matchtime=3         " show matching bracket for 0.3 seconds
set matchpairs+=<:>     " specially for html
set hidden              " remember undo after quitting
set confirm             " get a dialog when :q, :w, or :wq fails

" vim-easy-align mappings
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Setup vim-vue
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Prettier Configurations

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
" max line length that prettier will wrap on
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" use tabs over spaces
let g:prettier#config#use_tabs = 'false'

" print semicolons
let g:prettier#config#semi = 'true'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'false'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'

" none|es5|all
let g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = 'flow'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

"Vim-vue configurations
autocmd FileType vue syntax sync fromstart

" Vim vue syntastic configurations
" You need to manually install es lint and eslint-pligin
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif
