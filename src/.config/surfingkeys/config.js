const modes = {};

function addMode(mode, mapFn, mapkeyFn, unmapFn) {
	if (typeof mode === 'string') mode = { name: mode };
	mode.mapFn = mapFn;
	mode.mapkeyFn = mapkeyFn;
	mode.unmapFn = unmapFn;
	modes[mode.name] = mode;
}

function addProvider(key, name, url, ...args) {
	api.addSearchAlias(key, name, url, ...args);
	api.mapkey(
		`o${key}`,
		`#8Open Search with alias ${key}`,
		() => Front.openOmnibar({ type: 'SearchEngine', extra: key })
	);
}

function mapp(mode, ...args) {
	if (typeof mode === 'string') {
		args.unshift(mode);
		mode = modes.Normal;
	}
	if (args.length < 3) args.splice(1, 0, '');
	mode.mapkeyFn(...args);
}

function alias(mode, key, target, replace) {
	if (typeof mode === 'string') {
		replace = target;
		target = key;
		key = mode;
		mode = modes.Normal;
	}
	mode.mapFn(key, target);
	if (replace) unmapp(mode, target);
}

function unmapp(mode, keys) {
	if (arguments.length === 1) {
		keys = mode;
		mode = modes.Normal;
	}
	if (typeof keys === 'string') keys = [ keys ];
	for (const key of keys) mode.unmapFn(key);
}

function init() {
	addMode("Normal", api.map, api.mapkey, api.unmap);
	addMode("Insert", api.imap, api.imapkey, api.iunmap);
	addMode("Visual", api.vmap, api.vmapkey, api.vunmap);
}

function doSettings() {
	api.Hints.characters = 'aoeusnthidkbpg';
	chrome.storage.local.set({ "noPdfViewer": 1 });
	settings.caseSensitive = true;
	// settings.smartCase = true;
}

function mappings() {
	// TABS
	alias('dd', 'x', true);
	alias('gM', '<Alt-m>', true);
	alias('gp', '<Alt-p>', true);
	mapp(',r', '#4 Reload the page uncached', () => RUNTIME("reloadTab", { nocache: true }));
	alias('u', 'X', true);
	// alt-tab (pun)
	alias('<A-Tab>', 'gt');

	mapp('p', '#7 Paste URL in current tab', () => {
		Clipboard.read(({ data }) => (window.location.href = data));
	});
	mapp('P', '#7 Paste URL in new tab', () => {
		Clipboard.read(({ data }) => tabOpenLink(data));
	});

	// SCROLLING
	mapp('<Ctrl-y>', '#2 pageUp', () => api.Normal.scroll("pageUp"), { repeatIgnore: true });
	mapp('<Ctrl-e>', '#2 pageDown', () => api.Normal.scroll("pageDown"), { repeatIgnore: true });
	mapp('<Ctrl-u>', '#2 pageUp', () => api.Normal.scroll("pageUp"), { repeatIgnore: true });
	mapp('<Ctrl-d>', '#2 pageDown', () => api.Normal.scroll("pageDown"), { repeatIgnore: true });
	mapp('<Ctrl-b>', '#2 pageUp', () => api.Normal.scroll("pageUp"), { repeatIgnore: true });
	mapp('<Ctrl-f>', '#2 pageDown', () => api.Normal.scroll("pageDown"), { repeatIgnore: true });

	// HISTORY
	alias('H', 'S', true);
	alias('L', 'D', true);

	// LINKS
	alias('F', 'af', true);

	// NAV
	alias('st', 'su', true);
	api.mapkey('su', '#4 Edit current URL with vim editor (same tab)', () => {
		Front.showEditor(window.location.href, (url) => window.location = url, 'url');
	});
	api.mapkey('g#', '#4Reload current page without hash string (all parts after #)', function() {
			window.location.href = window.location.href.replace(/#[^\#]*$/, '');
	});

	// INPUT
	mapp('a', '#1 Append to edit box', () => {
		Hints.create("input:visible, textarea:visible, *[contenteditable=true], select:visible", Hints.dispatchMouseClick);
		const element = document.activeElement;
		// contenteditable
		if (element.setSelectionRange === undefined) {
			const selection = document.getSelection();
			selection.setPosition(selection.focusNode, selection.focusNode.data.length - 1);
			Visual.showCursor();
			Visual.hideCursor();
			return;
		}
		element.setSelectionRange(element.value.length, element.value.length);
	});
	alias('A', 'I');
	api.mapkey('ga', '#1 Go to last input', () => Hints.create("input[type=text]:visible:last", Hints.dispatchMouseClick));
	alias(modes.Insert, '<Ctrl-y>', '<Ctrl-i>', true);
	alias(modes.Insert, '<Ctrl-i>', '<Ctrl-f>', true);
	alias(modes.Insert, '<Ctrl-h>', '<Alt-b>');
	alias(modes.Insert, '<Ctrl-l>', '<Alt-f>');
}

function unmappings() {
	unmapp([
		'<Ctrl-i>',
		'B',
		'ab',
	]);

	// disable emojis
	unmapp(modes.Insert, ':');
}

function providers() {
	addProvider('D', 'dota', 'https://dota2.gamepedia.com/', 's', 'https://dota2.gamepedia.com/api/v1/SearchSuggestions/List?query=', (response) => {
		const data = JSON.parse(response.text);
		return data.items.map(({ title }) => title);
	});

	addProvider('T', "twitch", "https://twitch.tv/");
	addProvider('r', 'reddit', 'https://www.reddit.com/r/');

	addProvider('w', 'wikipedia', 'https://en.wikipedia.org/wiki/', 's', 'https://en.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=', (response) =>
		JSON.parse(response.text)[1]
	);
}

(function() {
	init();
	doSettings();
	mappings();
	unmappings();
	providers();
})();
