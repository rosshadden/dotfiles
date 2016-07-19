" PLUGINS

call plug#begin(expand(g:packageDir))
	" core

	Plug 'Shougo/vimproc.vim', { 'do': 'make' }

	" libraries

	Plug 'vim-scripts/ingo-library'
	Plug 'kana/vim-textobj-user'
	Plug 'kana/vim-operator-user'
	Plug 'dbakker/vim-projectroot'
	Plug 'xolox/vim-misc'

	" enhancements

	" sensible default settings
	Plug 'tpope/vim-sensible', LoadIf(!has('nvim'))
	" let `.` repeat things like plugin mappings
	Plug 'tpope/vim-repeat'
	" let `.` repeat things in visual mode
	Plug 'vim-scripts/visualrepeat'
	" completions
	Plug 'Shougo/deoplete.nvim', LoadIf(has('nvim'))
		\| Plug 'carlitux/deoplete-ternjs', LoadIf(has('nvim'))
	Plug 'Shougo/neocomplete.vim', LoadIf(!has('nvim'))
	" search with perl regex
	Plug 'othree/eregex.vim'
	" readline-style insersion
	Plug 'tpope/vim-rsi'
	" let <c-a>/<c-x> increment dates
	Plug 'tpope/vim-speeddating'
	" let <c-a>/<c-x> toggle certain words
	Plug 'mjbrownie/swapit'
	" load local .lvimrc files
	Plug 'embear/vim-localvimrc'

	" motions

	" gahdlike navigation
	Plug 'easymotion/vim-easymotion'
	" many useful text objects
	Plug 'wellle/targets.vim'
	" indents [ii, ai]
	Plug 'kana/vim-textobj-indent'
	" lines [ir, ar]
	Plug 'kana/vim-textobj-line'
	" entire buffer [ie, ae]
	Plug 'kana/vim-textobj-entire'
	" variable segment [iv, av]
	Plug 'Julian/vim-textobj-variable-segment'
	" pasted text [gb]
	Plug 'saaguero/vim-textobj-pastedtext'
	" camelCase
	Plug 'bkad/CamelCaseMotion'

	" operators

	" put in <motion> *mutters under breath*
	Plug 'kana/vim-operator-replace'
	" sort
	Plug 'christoomey/vim-sort-motion'

	" features

	" interact with surroundings
	Plug 'tpope/vim-surround'
	" snippets
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	" delimiter closing
	Plug 'Raimondi/delimitMate'
	" sessions
	Plug 'xolox/vim-session'
	" projects
	Plug 'dsawardekar/portkey'
	Plug 'dsawardekar/ember.vim'
	" swap windows
	Plug 'wesQ3/vim-windowswap'
	" language-aware line splits/joins
	Plug 'AndrewRadev/splitjoin.vim'
	" comments
	Plug 'tomtom/tcomment_vim'
	" settings toggles and symmetrical before/after mappings
	Plug 'tpope/vim-unimpaired'
	" visualized undo tree
	Plug 'sjl/gundo.vim'
	" multiple cursors
	Plug 'terryma/vim-multiple-cursors'
	" diff two selections
	Plug 'AndrewRadev/linediff.vim'
	" linter
	Plug 'benekastah/neomake'

	" ui

	Plug 'vim-airline/vim-airline'
	" indent guides
	Plug 'nathanaelkane/vim-indent-guides'
	" resize windows
	Plug 'talek/obvious-resize'
	" icon fonts
	Plug 'ryanoasis/vim-devicons'

	" utils

	" better buffer deletion
	Plug 'moll/vim-bbye'
	" auto-detect indent settings
	Plug 'tpope/vim-sleuth'
	" show trailing whitespace, and provide a command to clean it
	Plug 'ntpeters/vim-better-whitespace'
	" retab spaces => tabs, and vice versa
	Plug 'rhlobo/vim-super-retab'
	" context-filetype awareness
	Plug 'Shougo/context_filetype.vim'
	" async commands
	Plug 'tpope/vim-dispatch'
	" fast folding
	Plug 'Konfekt/FastFold'
	" fuzzyness
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	" alignment
	Plug 'junegunn/vim-easy-align'
	" emojis
	Plug 'junegunn/vim-emoji'

	" languages

	" autoformat support for multiple
	Plug 'Chiel92/vim-autoformat'
	" js
	Plug 'othree/yajs.vim', { 'for': 'javascript' }
	Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
	Plug 'marijnh/tern_for_vim', { 'do': 'npm install' , 'for': 'javascript' }
	" json
	Plug 'elzr/vim-json', { 'for': 'json' }
	" c#
	Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
	" html5
	Plug 'othree/html5.vim', { 'for': 'html' }
	" hbs
	Plug 'mustache/vim-mustache-handlebars'
	" jsdoc
	Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
	" rust
	Plug 'rust-lang/rust.vim'
	" emmet
	Plug 'mattn/emmet-vim'
	" i3 config
	Plug 'PotatoesMaster/i3-vim-syntax'
	" LaTeX
	Plug 'LaTeX-Box-Team/LaTeX-Box'
	" markdown
	Plug 'shime/vim-livedown'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	" emblem
	Plug 'heartsentwined/vim-emblem'
	" shell test framework
	Plug 'markcornick/vim-bats'
	" toml
	Plug 'cespare/vim-toml'

	" integration

	" git
	Plug 'airblade/vim-gitgutter'
	Plug 'codeindulgence/vim-tig'
	" editorconfig
	" TODO: inserts a weird search string on save
	" Plug 'editorconfig/editorconfig-vim'

	" external

	" seamless vim/tmux navigation
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'edkolev/promptline.vim'
	Plug 'edkolev/tmuxline.vim'
	Plug 'tmux-plugins/vim-tmux'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	" completions aware of other panes/windows, only when editing git commit messages
	Plug 'wellle/tmux-complete.vim', { 'for': [ 'gitcommit', 'pandoc' ] }
call plug#end()
