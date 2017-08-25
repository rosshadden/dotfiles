const modes = {};

function addMode(mode, mapFn, mapkeyFn, unmapFn) {
	if (typeof mode === 'string') mode = { name: mode };
	mode.mapFn = mapFn;
	mode.mapkeyFn = mapkeyFn;
	mode.unmapFn = unmapFn;
	modes[mode.name] = mode;
}

function addProvider(key, name, url, ...args) {
	addSearchAliasX(key, name, url, ...args);
	mapkey(
		`o${key}`,
		`#8Open Search with alias ${key}`,
		`Front.openOmnibar({ type: "SearchEngine", extra: "${key}" })`
	);
}

function mapp(mode, ...args) {
	if (typeof mode === 'string') {
		args.unshift(mode);
		mode = modes.Normal;
	}
	mode.mapkeyFn(...args);
}

function alias(mode, key, target) {
	if (typeof mode === 'string') {
		target = key;
		key = mode;
		mode = modes.Normal;
	}
	const mapping = mode.mappings.find(encodeKeystroke(target));
	if (mapping) mode.mapkeyFn(key, mapping.meta.annotation || '', mapping.meta.code);
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
	addMode(Normal, map, mapkey, unmap);
	addMode(Insert, imap, imapkey, iunmap);
	addMode(Visual, vmap, vmapkey, vunmap);
	addMode('Console', cmap, cmapkey, () => { throw new Error('Not implemented'); });
}

function settings() {
	Hints.characters = 'aoeusnthidkbpg';
	chrome.storage.local.set({ "noPdfViewer": 0 });
}

function mappings() {
	// HISTORY
	alias('H', 'S');
	alias('L', 'D');

	// TABS
	alias('gM', '<Alt-m>');
	mapp(',r', '#4Reload the page uncached', 'RUNTIME("reloadTab", { nocache: true })');
	alias('u', 'X');
	// alt-tab (pun)
	alias('<A-Tab>', 'gt');
	alias(modes.Insert, '<A-Tab>', 'gt');

	// LINKS
	alias('F', 'af');

	// INSERT
	mapp('a', '#1Append in edit box', 'Hints.create("input:visible, textarea:visible, *[contenteditable=true], select:visible", Hints.dispatchMouseClick)');
	alias(modes.Insert, '<Ctrl-o>', '<Ctrl-i>');
	alias(modes.Insert, '<Ctrl-i>', '<Ctrl-f>');
}

function unmappings() {
	unmapp([
		'<Alt-m>',
		'<Alt-p>',
		'<Ctrl-i>',
		'B',
		'D',
		'S',
		'X',
		'ab',
		'af',
	]);
	unmapp(modes.Insert, [
		'<Ctrl-f>'
	]);
}

function providers() {
	addProvider('G', 'github', 'https://github.com/search?type=Code&utf8=%E2%9C%93&q=');
	addProvider('r', 'reddit', 'http://www.reddit.com/r/');
	addProvider('w', 'wikipedia', 'https://en.wikipedia.org/w/index.php?search=', 's');
}

init();
settings();
mappings();
unmappings();
providers();
