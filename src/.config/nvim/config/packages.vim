" PLUGINS

call plug#begin(expand(g:packageDir))
	" core

	Plug 'Shougo/vimproc.vim', { 'do': 'make' }

	" libraries

	Plug 'vim-scripts/ingo-library'
	Plug 'dbakker/vim-projectroot'

	" enhancements

	" sensible default settings
	Plug 'tpope/vim-sensible', LoadIf(!has('nvim'))
	" let `.` repeat things like plugin mappings
	Plug 'tpope/vim-repeat'
	" let `.` repeat things in visual mode
	Plug 'vim-scripts/visualrepeat'
	" completions
	Plug 'Shougo/deoplete.nvim', LoadIf(has('nvim'))
		\| Plug 'carlitux/deoplete-ternjs', LoadIf(has('nvim'), { 'do': 'npm install -g tern' })
		\| Plug 'tweekmonster/deoplete-clang2', LoadIf(has('nvim'))
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

	" text objects

	Plug 'kana/vim-textobj-user'
		\| Plug 'kana/vim-textobj-indent'
		\| Plug 'kana/vim-textobj-line'
		\| Plug 'kana/vim-textobj-entire'
		\| Plug 'Julian/vim-textobj-variable-segment'
		\| Plug 'saaguero/vim-textobj-pastedtext'
		\| Plug 'jceb/vim-textobj-uri'
	" many useful text objects
	Plug 'wellle/targets.vim'
	" camelCase
	Plug 'bkad/CamelCaseMotion'

	" motions

	Plug 'kana/vim-operator-user'
		\| Plug 'kana/vim-operator-replace' " put in <motion> *mutters under breath*
	" gahdlike navigation
	Plug 'easymotion/vim-easymotion'
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
	Plug 'neomake/neomake'
		\| Plug 'coddingtonbear/neomake-platformio'
	" visual star search
	Plug 'bronson/vim-visual-star-search'

	" ui

	" highlight yanked regions
	Plug 'machakann/vim-highlightedyank'
	" status bar
	Plug 'vim-airline/vim-airline'
	" indent guides
	Plug 'nathanaelkane/vim-indent-guides'
	" resize windows
	Plug 'talek/obvious-resize'
	" icon fonts
	Plug 'ryanoasis/vim-devicons'
	" colorize colors
	Plug 'ap/vim-css-color'

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

	" polyglot support
	Plug 'sheerun/vim-polyglot'
	" polyglot autoformat support
	Plug 'Chiel92/vim-autoformat'
	" markdown
	Plug 'shime/vim-livedown'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	" js
	Plug 'othree/yajs.vim', { 'for': 'javascript' }
	Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
	Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
	Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
	Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm i' }
	" ts
	Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
	" rust
	Plug 'racer-rust/vim-racer', { 'for': 'rust' }
	" moonscript
	Plug 'leafo/moonscript-vim', { 'for': 'moon' }
	" i3 config
	Plug 'PotatoesMaster/i3-vim-syntax'
	" c#
	Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
	" shell test framework
	Plug 'markcornick/vim-bats', { 'for': 'bats' }
	" emmet
	Plug 'mattn/emmet-vim', { 'for': 'html' }
	" nim
	Plug 'baabelfish/nvim-nim', { 'for': [ 'nim', 'nims', 'nimble' ] }
	" godot
	Plug 'quabug/vim-gdscript', { 'for': 'gd' }

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
	" TODO: pending https://github.com/edkolev/tmuxline.vim/pull/75
	" Plug 'edkolev/tmuxline.vim'
	Plug 'munyari/tmuxline.vim', { 'branch': 'utf8' }
	Plug 'tmux-plugins/vim-tmux'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	" completions aware of other panes/windows, only when editing git commit messages
	Plug 'wellle/tmux-complete.vim', { 'for': [ 'gitcommit', 'markdown', 'pandoc' ] }
call plug#end()
