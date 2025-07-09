function alias(key, target, replace = false) {
	api.map(key, target);
	if (replace) api.unmap(target);
}

function addProvider(key, name, url, ...args) {
	api.addSearchAlias(key, name, url, ...args);
	api.mapkey(
		`o${key}`,
		`#8Open Search with alias ${key}`,
		() => api.Front.openOmnibar({ type: "SearchEngine", extra: key })
	);
}

function scroll(amount = 0) {
	window.scrollTo(0, window.pageYOffset + amount);
}

function options() {
	api.Hints.setCharacters("cnisetahywodulxfjmkr");
	// chrome.storage.local.set({ "noPdfViewer": 1 });
	settings.smartCase = true;
}

function mappings() {
	// DEBUG
	api.mapkey("<Backspace>", "#0 debug", () => {
		console.log("api", api);
		console.log("settings", settings);
	});

	// HISTORY
	alias("H", "S", true);
	alias("L", "D", true);

	// TABS

	// reopen
	alias("u", "X", true);
	// mute
	alias("gM", "<Alt-m>", true);
	// pin
	alias("gp", "<Alt-p>", true);
	// alt-tab (pun)
	alias("<A-Tab>", "gt");

	api.mapkey(",r", "#4 Reload the page uncached", () => api.RUNTIME("reloadTab", { nocache: true }));

	api.mapkey("p", "#7 Paste URL in current tab", () => {
		api.Clipboard.read(({ data }) => (window.location.href = data));
	});
	api.mapkey("P", "#7 Paste URL in new tab", () => {
		api.Clipboard.read(({ data }) => api.tabOpenLink(data));
	});

	// SCROLLING
	api.mapkey("<Ctrl-b>", "#2 page up", () => scroll(-1 * 0.9 * window.innerHeight));
	api.mapkey("<Ctrl-f>", "#2 page down", () => scroll(1 * 0.9 * window.innerHeight));
	api.mapkey("<Ctrl-u>", "#2 half page up", () => scroll(-1 * 0.45 * window.innerHeight));
	api.mapkey("<Ctrl-d>", "#2 half page down", () => scroll(1 * 0.45 * window.innerHeight));

	// INPUT
	api.mapkey("ga", "#1 Go to last input", () => api.Hints.create("input[type=text]:last-of-type", api.Hints.dispatchMouseClick));
}

function unmappings() {
	api.unmap("C");
	api.unmap("d");
	api.unmap("D");

	// disable emojis
	api.iunmap(":");
	api.iunmap("<Ctrl-a>");
}

function providers() {
	addProvider("D", "dota", "https://liquipedia.net/dota2/", "s", "https://liquipedia.net/dota2/api.php?action=opensearch&format=json&search=", (res) => {
		const [ query, titles, , urls ] = JSON.parse(res.text);
		return titles;
	});
	addProvider("G", "godot", "https://docs.godotengine.org/en/latest/search.html?q=");
	addProvider("r", "reddit", "https://www.reddit.com/r/");
	addProvider("S", "slippi", "https://slippi.gg/user/");
	addProvider("T", "twitch", "https://twitch.tv/");
	addProvider("w", "wikipedia", "https://en.wikipedia.org/wiki/", "s", "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=", (res) => {
		return JSON.parse(res.text)[1];
	});
}

(() => {
	options();
	mappings();
	unmappings();
	providers();
})();
