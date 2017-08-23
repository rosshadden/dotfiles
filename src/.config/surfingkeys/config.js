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

function mapp(mode, key, fn, description) {
	if (typeof mode === 'string') {
		description = fn;
		fn = key;
		key = mode;
		mode = modes.Normal;
	}
	if (!fn) return;
	if (typeof fn === 'string') {
		const mapping = mode.mappings.find(encodeKeystroke(fn));
		if (mapping) mode.mapkeyFn(key, mapping.meta.annotation || '', mapping.meta.code);
		return;
	}
	mode.mapkeyFn(key, description || '', fn);
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
	mapp('H', 'S');
	mapp('L', 'D');

	// TABS
	mapp('gM', '<Alt-m>');
	mapp(',r', '#4Reload the page uncached', 'RUNTIME("reloadTab", { nocache: true })');
	mapp('u', 'X');
	// alt-tab (pun)
	mapp('<A-Tab>', 'gt');
	mapp(modes.Insert, '<A-Tab>', 'gt');

	// INSERT
	mapp(modes.Insert, '<Ctrl-o>', '<Ctrl-i>');
}

function unmappings() {
	unmapp([
		'<Alt-m>',
		'<Alt-p>',
		'<Ctrl-i>',
		'B',
		'D',
		'E',
		'F',
		'R',
		'S',
		'X'
	]);
	unmapp(modes.Insert, [
		'<Ctrl-i>'
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
