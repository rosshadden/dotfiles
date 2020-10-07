const qwerty = require("./qwerty.json");

function makeKeys() {
	const keys = qwerty.keys;

	keys["q"] = "y";
	keys["w"] = "q";
	keys["e"] = "w";
	keys["r"] = "e";
	keys["t"] = "r";
	keys["y"] = "t";

	keys["a"] = "h";
	keys["s"] = "a";
	keys["d"] = "s";
	keys["f"] = "d";
	keys["g"] = "f";
	keys["h"] = "g";

	keys["z"] = "n";
	keys["x"] = "z";
	keys["c"] = "x";
	keys["v"] = "c";
	keys["b"] = "v";
	keys["n"] = "b";

	keys["pause"] = "@qwr";

	return keys;
}

module.exports = {
	name: "games",
	keys: makeKeys(),
};
