" Disable vi-compatibility
set nocompatible

if has ('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" PLUGINS
	" Let NeoBundle manage NeoBundle
	NeoBundleFetch 'Shougo/neobundle.vim'

	NeoBundle 'Shougo/vimproc.vim', {
		\ 'build' : {
			\ 'windows' : 'tools\\update-dll-mingw',
			\ 'cygwin' : 'make -f make_cygwin.mak',
			\ 'mac' : 'make -f make_mac.mak',
			\ 'unix' : 'make -f make_unix.mak',
		\ }
	\ }

	" libraries
		NeoBundle 'vim-scripts/ingo-library'
		NeoBundle 'kana/vim-textobj-user'
		NeoBundle 'kana/vim-operator-user'

	" enhancements
		" let `.` repeat things like plugin mappings
		NeoBundle 'tpope/vim-repeat'
		" let `.` repeat things in visual mode
		NeoBundle 'vim-scripts/visualrepeat'
		" completions in insert mode
		NeoBundle 'Shougo/neocomplete.vim'
		" <tab>-complete in the search prompt
		NeoBundle 'SearchComplete'
		" search with perl regex
		NeoBundle 'othree/eregex.vim'
		" readline-style insersion
		NeoBundle 'tpope/vim-rsi'
		" let <c-a>/<c-x> increment dates
		NeoBundle 'tpope/vim-speeddating'
		" let <c-a>/<c-x> toggle certain words
		NeoBundle 'mjbrownie/swapit'
		" load local .lvimrc files
		NeoBundle 'embear/vim-localvimrc'

	" motions
		" gahdlike navigation
		NeoBundle 'Lokaltog/vim-easymotion'
		" many useful text objects
		NeoBundle 'wellle/targets.vim'
		" indents [ii, ai]
		NeoBundle 'kana/vim-textobj-indent'
		" lines [il, al]
		NeoBundle 'kana/vim-textobj-line'
		" entire buffer [ie, ae]
		NeoBundle 'kana/vim-textobj-entire'
		" variable segment [iv, av]
		NeoBundle 'Julian/vim-textobj-variable-segment'
		" pasted text [gb]
		NeoBundle 'saaguero/vim-textobj-pastedtext'
		" camelCase
		NeoBundle 'bkad/CamelCaseMotion'

	" operators
		" put in <motion> *mutters under breath*
		NeoBundle 'kana/vim-operator-replace'
		" sort
		NeoBundle 'christoomey/vim-sort-motion'

	" features
		" snippets
		NeoBundle 'Shougo/neosnippet.vim'
		NeoBundle 'Shougo/neosnippet-snippets'
		" delimiter closing
		NeoBundle 'Raimondi/delimitMate'

	" files
		" file trees for people that like file trees
		NeoBundle 'Shougo/vimfiler.vim'

	" integration
		" git
		NeoBundle 'tpope/vim-fugitive'
		NeoBundle 'airblade/vim-gitgutter'
		" ag, the silver searcher
		NeoBundle 'rking/ag.vim'
		" file managers and terminals
		NeoBundle 'justinmk/vim-gtfo'
		" vifm
		NeoBundle 'vifm/vifm.vim'
		" taskwarrior
		NeoBundle 'farseer90718/vim-taskwarrior'
		" zeal
		NeoBundle 'KabbAmine/zeavim.vim'

	" UI
		NeoBundle 'bling/vim-airline'
		NeoBundle 'paranoida/vim-airlineish'
		" colors
		NeoBundle 'chriskempson/base16-vim'
		" indent guides
		NeoBundle 'nathanaelkane/vim-indent-guides'
		" resize windows
		NeoBundle 'talek/obvious-resize'

	" languages
		" autoformat support for multiple
		NeoBundle 'Chiel92/vim-autoformat'

		" js
		NeoBundleLazy 'othree/yajs.vim', { 'rev': 'fold', 'autoload': { 'filetypes': 'javascript' } }
		NeoBundleLazy 'othree/javascript-libraries-syntax.vim', { 'autoload': { 'filetypes': 'javascript' } }
		" folding
		" AST
		NeoBundleLazy 'marijnh/tern_for_vim', { 'autoload': { 'filetypes': 'javascript' } }

		" json
		NeoBundleLazy 'elzr/vim-json', { 'autoload': { 'filetypes': 'json' } }
		" html5
		NeoBundleLazy 'othree/html5.vim', { 'autoload': { 'filetypes': 'html' } }
		" hbs
		NeoBundle 'mustache/vim-mustache-handlebars'
		" jsdoc
		NeoBundleLazy 'heavenshell/vim-jsdoc', { 'autoload': { 'filetypes': 'javascript' } }
		" emmet
		NeoBundle 'mattn/emmet-vim'
		" i3 config
		NeoBundle 'PotatoesMaster/i3-vim-syntax'
		" stylus
		NeoBundle 'wavded/vim-stylus'
		" LaTeX
		NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
		" markdown
		NeoBundle 'godlygeek/tabular'
		NeoBundle 'suan/vim-instant-markdown'
		NeoBundle 'vim-pandoc/vim-pandoc'
		NeoBundle 'vim-pandoc/vim-pandoc-syntax'

	" unite
		NeoBundle 'Shougo/unite.vim'
		NeoBundle 'Shougo/neomru.vim'
		NeoBundle 'Shougo/unite-outline'
		NeoBundle 'thinca/vim-unite-history'
		NeoBundle 'Shougo/tabpagebuffer.vim'
		NeoBundle 'kopischke/unite-spell-suggest'
		NeoBundle 'Shougo/neossh.vim'

	" scripting
		NeoBundle 'dbakker/vim-projectroot'

	" projects
		NeoBundle 'dsawardekar/portkey'
		NeoBundle 'dsawardekar/ember.vim'

	" utils
		" sensible default settings
		NeoBundle 'tpope/vim-sensible'
		" auto-detuct indent settings
		NeoBundle 'tpope/vim-sleuth'
		NeoBundle 'tpope/vim-surround'
		" comment mappings
		NeoBundle 'tpope/vim-commentary'
		NeoBundle 'scrooloose/nerdcommenter'
		" settings toggles and symmetrical before/after mappings
		NeoBundle 'tpope/vim-unimpaired'
		" visualized undo tree
		NeoBundle 'sjl/gundo.vim'
		" better multiple-cursor functionality
		NeoBundle 'terryma/vim-multiple-cursors'
		" diff two selections
		NeoBundle 'AndrewRadev/linediff.vim'
		NeoBundle 'scrooloose/syntastic'
		NeoBundle 'thinca/vim-qfreplace'
		" show trailing whitespace, and provide a command to clean it
		NeoBundle 'ntpeters/vim-better-whitespace'
		" sessions
		NeoBundle 'xolox/vim-session'
		NeoBundle 'xolox/vim-misc'
		" retab spaces => tabs, and vice versa
		NeoBundle 'rhlobo/vim-super-retab'
		" context-filetype awareness
		NeoBundle 'Shougo/context_filetype.vim'
		" async commands
		NeoBundle 'tpope/vim-dispatch'
		" swap windows
		NeoBundle 'wesQ3/vim-windowswap'
		" language-aware line splits/joins
		NeoBundle 'AndrewRadev/splitjoin.vim'

	" external
		NeoBundle 'tmux-plugins/vim-tmux'
		NeoBundle 'tmux-plugins/vim-tmux-focus-events'
		NeoBundle 'christoomey/vim-tmux-navigator'
		NeoBundle 'edkolev/tmuxline.vim'
		NeoBundle 'edkolev/promptline.vim'
" /PLUGINS

call neobundle#end()

" Prompt to install any newly added bundles
NeoBundleCheck
