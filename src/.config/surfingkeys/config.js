const modes = {};

function addMode(mode, mapFn, mapkeyFn) {
	if (typeof mode === 'string') mode = { name: mode };
	mode.mapFn = mapFn;
	mode.mapkeyFn = mapkeyFn;
	mode.keys = [];
	modes[mode.name] = mode;
}

function mapp(mode, key, fn, description) {
	if (typeof mode === 'string') {
		description = fn;
		fn = key;
		key = mode;
		mode = Normal;
	}
	mode.keys.push(key);
	if (!fn) return;
	mode.mapkeyFn(key, description, fn);
}

function alias(mode, key, to) {
	if (typeof mode === 'string') {
		to = key;
		key = mode;
		mode = Normal;
	}
	const meta = mode.mappings.find(encodeKeystroke(to)).meta;
	mode.keys.push(key);
	mode.mapkeyFn(key, meta.annotation, meta.code);
}

function unmapDefaults() {
	for (let name in modes) {
		const mode = modes[name];
		const mappings = new Trie();
		for (let key of mode.keys) {
			const map = encodeKeystroke(key);
			const node = mode.mappings.find(map);
			if (node) mappings.add(map, node.meta);
		}
		delete mode.mappings;
		mode.mappings = mappings;
		mode.map_node = mappings;
	}
}

function init() {
	addMode(Normal, map, mapkey);
	addMode(Insert, imap, imapkey);
	addMode(Visual, vmap, vmapkey);
	addMode('Console', cmap, cmapkey);
}

function main() {
	mapp(':')
	mapp('?')
	alias('<Ctrl-o>', '<Ctrl-i>');

	unmapDefaults();

	imap('<Ctrl-o>', '<Ctrl-i>');
}

init();
main();
