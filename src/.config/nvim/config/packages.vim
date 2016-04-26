" Disable vi-compatibility
set nocompatible

if has('vim_starting')
	set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
endif

" PLUGINS

call dein#begin(expand('~/.config/nvim/dein'))
	" Let dein manage dein
	call dein#add('Shougo/dein.vim')

	" core

	call dein#add('Shougo/vimproc.vim', { 'build': 'make' })

	" libraries

	call dein#add('vim-scripts/ingo-library')
	call dein#add('kana/vim-textobj-user')
	call dein#add('kana/vim-operator-user')
	call dein#add('dbakker/vim-projectroot')
	call dein#add('xolox/vim-misc')

	" enhancements

	" sensible default settings
	if !has('nvim')
		call dein#add('tpope/vim-sensible')
	endif
	" let `.` repeat things like plugin mappings
	call dein#add('tpope/vim-repeat')
	" let `.` repeat things in visual mode
	call dein#add('vim-scripts/visualrepeat')
	" completions in insert mode
	if has('nvim')
		call dein#add('Shougo/deoplete.nvim')
	else
		call dein#add('Shougo/neocomplete.vim')
	endif
	" <tab>-complete in the search prompt
	call dein#add('SearchComplete')
	" search with perl regex
	call dein#add('othree/eregex.vim')
	" readline-style insersion
	call dein#add('tpope/vim-rsi')
	" let <c-a>/<c-x> increment dates
	call dein#add('tpope/vim-speeddating')
	" let <c-a>/<c-x> toggle certain words
	call dein#add('mjbrownie/swapit')
	" load local .lvimrc files
	call dein#add('embear/vim-localvimrc')

	" motions

	" gahdlike navigation
	call dein#add('easymotion/vim-easymotion')
	" many useful text objects
	call dein#add('wellle/targets.vim')
	" indents [ii, ai]
	call dein#add('kana/vim-textobj-indent')
	" lines [ir, ar]
	call dein#add('kana/vim-textobj-line')
	" entire buffer [ie, ae]
	call dein#add('kana/vim-textobj-entire')
	" variable segment [iv, av]
	call dein#add('Julian/vim-textobj-variable-segment')
	" pasted text [gb]
	call dein#add('saaguero/vim-textobj-pastedtext')
	" camelCase
	call dein#add('bkad/CamelCaseMotion')

	" operators

	" put in <motion> *mutters under breath*
	call dein#add('kana/vim-operator-replace')
	" sort
	call dein#add('christoomey/vim-sort-motion')

	" features

	" interact with surroundings
	call dein#add('tpope/vim-surround')
	" snippets
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	" delimiter closing
	call dein#add('Raimondi/delimitMate')
	" sessions
	call dein#add('xolox/vim-session')
	" projects
	call dein#add('dsawardekar/portkey')
	call dein#add('dsawardekar/ember.vim')
	" swap windows
	call dein#add('wesQ3/vim-windowswap')
	" language-aware line splits/joins
	call dein#add('AndrewRadev/splitjoin.vim')
	" comments
	call dein#add('tpope/vim-commentary')
	call dein#add('scrooloose/nerdcommenter')
	" settings toggles and symmetrical before/after mappings
	call dein#add('tpope/vim-unimpaired')
	" visualized undo tree
	call dein#add('sjl/gundo.vim')
	" multiple cursors
	call dein#add('terryma/vim-multiple-cursors')
	" diff two selections
	call dein#add('AndrewRadev/linediff.vim')
	" linter
	call dein#add('scrooloose/syntastic')


	" files

	" file trees for people that like file trees
	call dein#add('Shougo/vimfiler.vim')

	" UI

	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('paranoida/vim-airlineish')
	" colors
	call dein#add('chriskempson/base16-vim')
	" indent guides
	call dein#add('nathanaelkane/vim-indent-guides')
	" resize windows
	call dein#add('talek/obvious-resize')

	" utils

	" auto-detect indent settings
	call dein#add('tpope/vim-sleuth')
	" show trailing whitespace, and provide a command to clean it
	call dein#add('ntpeters/vim-better-whitespace')
	" retab spaces => tabs, and vice versa
	call dein#add('rhlobo/vim-super-retab')
	" context-filetype awareness
	call dein#add('Shougo/context_filetype.vim')
	" async commands
	call dein#add('tpope/vim-dispatch')
	" fast folding
	call dein#add('Konfekt/FastFold')

	" languages

	" autoformat support for multiple
	call dein#add('Chiel92/vim-autoformat')
	" js
	call dein#add('othree/yajs.vim', { 'lazy': 1, 'on_ft': 'javascript' })
	call dein#add('othree/javascript-libraries-syntax.vim', { 'lazy': 1, 'on_ft': 'javascript' })
	call dein#add('marijnh/tern_for_vim', { 'lazy': 1, 'on_ft': 'javascript' })
	" json
	call dein#add('elzr/vim-json', { 'lazy': 1, 'on_ft': 'json' })
	" c#
	call dein#add('OmniSharp/omnisharp-vim', { 'lazy': 1, 'on_ft': 'cs' })
	" html5
	call dein#add('othree/html5.vim', { 'lazy': 1, 'on_ft': 'html' })
	" hbs
	call dein#add('mustache/vim-mustache-handlebars')
	" jsdoc
	call dein#add('heavenshell/vim-jsdoc', { 'lazy': 1, 'on_ft': 'javascript' })
	" emmet
	call dein#add('mattn/emmet-vim')
	" i3 config
	call dein#add('PotatoesMaster/i3-vim-syntax')
	" stylus
	call dein#add('wavded/vim-stylus')
	" LaTeX
	call dein#add('LaTeX-Box-Team/LaTeX-Box')
	" markdown
	call dein#add('godlygeek/tabular')
	call dein#add('shime/vim-livedown')
	call dein#add('vim-pandoc/vim-pandoc')
	call dein#add('vim-pandoc/vim-pandoc-syntax')
	" emblem
	call dein#add('heartsentwined/vim-emblem')
	call dein#add('markcornick/vim-bats')

	" unite

	call dein#add('Shougo/unite.vim')
	call dein#add('kopischke/unite-spell-suggest', { 'depends': 'Shougo/unite.vim' })
	call dein#add('osyo-manga/unite-quickfix', { 'depends': 'Shougo/unite.vim' })
	call dein#add('Shougo/neomru.vim', { 'depends': 'Shougo/unite.vim' })
	call dein#add('Shougo/neossh.vim', { 'depends': 'Shougo/unite.vim' })
	call dein#add('Shougo/tabpagebuffer.vim', { 'depends': 'Shougo/unite.vim' })
	call dein#add('Shougo/unite-outline', { 'depends': 'Shougo/unite.vim' })
	call dein#add('thinca/vim-unite-history', { 'depends': 'Shougo/unite.vim' })

	" integration

	" git
	call dein#add('airblade/vim-gitgutter')
	call dein#add('tpope/vim-fugitive')
	" editorconfig
	call dein#add('editorconfig/editorconfig-vim')
	" ag, the silver searcher
	call dein#add('rking/ag.vim')
	" file managers and terminals
	call dein#add('justinmk/vim-gtfo')
	" vifm
	call dein#add('vifm/vifm.vim')
	" taskwarrior
	call dein#add('farseer90718/vim-taskwarrior')
	" zeal
	call dein#add('KabbAmine/zeavim.vim')

	" external

	" seamless vim/tmux navigation
	call dein#add('christoomey/vim-tmux-navigator')
	call dein#add('edkolev/promptline.vim')
	call dein#add('edkolev/tmuxline.vim')
	call dein#add('tmux-plugins/vim-tmux')
	call dein#add('tmux-plugins/vim-tmux-focus-events')
	" completions aware of other panes/windows, only when editing git commit messages
	call dein#add('wellle/tmux-complete.vim', { 'on_ft': [ 'gitcommit', 'pandoc' ] })
call dein#end()

" Prompt to install any newly added bundles
if dein#check_install()
	call dein#install()
endif
