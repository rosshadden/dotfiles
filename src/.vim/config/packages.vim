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
	\     'windows' : 'tools\\update-dll-mingw',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make -f make_mac.mak',
	\     'unix' : 'make -f make_unix.mak',
	\    },
	\ }

	" enhancements
		" let `.` repeat things like plugin mappings
		NeoBundle 'tpope/vim-repeat'
		" let `.` repeat things in visual mode
		NeoBundle 'visualrepeat'
		" <tab>-complete in insert mode
		" NeoBundle 'ervandew/supertab'
		NeoBundle 'Shougo/neocomplete.vim'
		" <tab>-complete in the search prompt
		NeoBundle 'SearchComplete'
		" search with perl regex
		NeoBundle 'othree/eregex.vim'
		" readline-style insersion
		NeoBundle 'tpope/vim-rsi'

	" navigation
		NeoBundle 'Lokaltog/vim-easymotion'

	" motions
		NeoBundle 'bkad/CamelCaseMotion'

	" languages
		" autoformat support for multiple
		NeoBundle 'Chiel92/vim-autoformat'
		" js
		NeoBundle 'pangloss/vim-javascript'
		NeoBundle 'jelera/vim-javascript-syntax'
		" js AST
		NeoBundle 'marijnh/tern_for_vim'
		" json
		NeoBundle 'elzr/vim-json'
		" hbs
		NeoBundle 'mustache/vim-mustache-handlebars'
		" jsdoc
		NeoBundle 'heavenshell/vim-jsdoc'
		" emmet
		NeoBundle 'mattn/emmet-vim'
		" i3 config
		NeoBundle 'PotatoesMaster/i3-vim-syntax'
		" stylus
		NeoBundle 'wavded/vim-stylus'
		" LaTeX
		NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
		" markdown
		NeoBundle 'suan/vim-instant-markdown'

	" features
		" snippets
		NeoBundle 'Shougo/neosnippet.vim'
		NeoBundle 'Shougo/neosnippet-snippets'

	" integration
		" git
		NeoBundle 'tpope/vim-fugitive'
		" ag, the silver searcher
		NeoBundle 'rking/ag.vim'
		" vifm
		NeoBundle 'vifm/vifm.vim'

	" UI
		NeoBundle 'bling/vim-airline'
		NeoBundle 'paranoida/vim-airlineish'
		" sexy scrolling, with easing and animation
		" NOTE: messes with mouse scrolling, which currently upsets me
		" NeoBundle 'joeytwiddle/sexy_scroller.vim'
		" colors
		NeoBundle 'chriskempson/base16-vim'

	" unite
		NeoBundle 'Shougo/unite.vim'
		NeoBundle 'Shougo/neomru.vim'
		NeoBundle 'Shougo/unite-outline'
		NeoBundle 'thinca/vim-unite-history'
		NeoBundle 'Shougo/tabpagebuffer.vim'

	" scripting
		NeoBundle 'dbakker/vim-projectroot'

	" utils
		" sensible default settings
		NeoBundle 'tpope/vim-sensible'
		" auto-detuct indent settings
		NeoBundle 'tpope/vim-sleuth'
		NeoBundle 'tpope/vim-surround'
		" comment mappings
		NeoBundle 'tpope/vim-commentary'
		" settings toggles and symmetrical before/after mappings
		NeoBundle 'tpope/vim-unimpaired'
		NeoBundle 'scrooloose/nerdtree'
		NeoBundle 'jistr/vim-nerdtree-tabs'
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

	" external
		NeoBundle 'christoomey/vim-tmux-navigator'
		NeoBundle 'edkolev/tmuxline.vim'
		NeoBundle 'edkolev/promptline.vim'
" /PLUGINS

call neobundle#end()

" Prompt to install any newly added bundles
NeoBundleCheck
