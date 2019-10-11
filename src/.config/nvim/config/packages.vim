" PLUGINS

call plug#begin(expand(g:packageDir))
	" core

	Plug 'Shougo/vimproc.vim', { 'do': 'make' }

	" libraries

	Plug 'dbakker/vim-projectroot'
	Plug 'roxma/nvim-yarp'
	Plug 'vim-scripts/ingo-library'

	" enhancements

	" sensible default settings
	Plug 'tpope/vim-sensible', LoadIf(!has('nvim'))
	" let `.` repeat things like plugin mappings
	Plug 'tpope/vim-repeat'
	" let `.` repeat things in visual mode
	Plug 'vim-scripts/visualrepeat'
	" search with perl regex
	Plug 'othree/eregex.vim'
	" readline-style insertion
	Plug 'tpope/vim-rsi'
	" let <c-a>/<c-x> increment dates
	Plug 'tpope/vim-speeddating'
	" let <c-a>/<c-x> toggle certain words
	Plug 'mjbrownie/swapit'
	" load local .lvimrc files
	Plug 'embear/vim-localvimrc'
	" look at registers
	Plug 'junegunn/vim-peekaboo'
	" completions
	Plug 'ncm2/ncm2'
		\| Plug 'ncm2/ncm2-bufword'
		\| Plug 'ncm2/ncm2-path'
		\| Plug 'fgrsnau/ncm2-aspell'
		\| Plug 'ncm2/ncm2-syntax'
			\| Plug 'Shougo/neco-syntax'
		\| Plug 'ncm2/ncm2-neosnippet'
		\| Plug 'ncm2/ncm2-vim', { 'for': 'vim' }
			\| Plug 'Shougo/neco-vim', { 'for': 'vim' }
		\| Plug 'ncm2/ncm2-tern', { 'for': 'javascript', 'do': 'npm install' }
		\| Plug 'ncm2/ncm2-tmux', { 'for': [ 'text', 'config', 'markdown', 'pandoc', 'yaml', 'make', 'sh', 'gitcommit' ] }
	if !has('nvim')
		Plug 'roxma/vim-hug-neovim-rpc'
	endif
	Plug 'Shougo/echodoc.vim'

	" text objects and motions

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
	" user-defined operator library
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
	" swap windows
	Plug 'wesQ3/vim-windowswap'
	" language-aware line splits/joins
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'sk1418/Join'
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
	Plug 'dense-analysis/ale'
	" visual star search
	Plug 'bronson/vim-visual-star-search'
	" tagbar
	Plug 'majutsushi/tagbar'

	" ui

	" highlight yanked regions
	Plug 'machakann/vim-highlightedyank'
	" status bar
	Plug 'itchyny/lightline.vim'
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
	Plug 'euclio/vim-markdown-composer', { 'do': 'cargo build --release' }
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	" js
	Plug 'othree/yajs.vim', { 'for': 'javascript' }
	Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
	Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
	Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
	Plug 'moll/vim-node', { 'for': 'javascript' }
	" ts
	Plug 'mhartington/nvim-typescript', { 'for': 'typescript', 'do': './install.sh' }
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
	" Plug 'erw7/nim.vim', { 'for': [ 'nim', 'nims', 'nimble' ], 'branch': 'develop' }
	" Plug 'JCavallo/nvim-nim', { 'for': [ 'nim', 'nims', 'nimble' ] }
	Plug 'alaviss/nim.nvim', { 'for': [ 'nim', 'nims', 'nimble' ] }
	" clojure
	Plug 'clojure-vim/async-clj-omni', { 'for': 'clojure' }
	Plug 'eraserhd/parinfer-rust', { 'for': 'clojure', 'do': 'cargo build --release' }
	" godot
	Plug 'calviken/vim-gdscript3'

	" integration

	" git
	Plug 'airblade/vim-gitgutter'
	Plug 'codeindulgence/vim-tig'
	" editorconfig
	Plug 'editorconfig/editorconfig-vim'

	" external

	" seamless vim/tmux navigation
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'edkolev/tmuxline.vim'
	Plug 'tmux-plugins/vim-tmux'
	Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()
