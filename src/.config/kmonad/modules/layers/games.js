const qwerty = require("./qwerty.json");

function makeKeys() {
	const keys = qwerty.keys;

	keys["q"] = "]";
	keys["w"] = "q";
	keys["e"] = "w";
	keys["r"] = "e";
	keys["t"] = "r";
	keys["y"] = "t";
	keys["u"] = "y";
	keys["i"] = "u";
	keys["o"] = "i";
	keys["p"] = "o";
	keys["["] = "p";
	keys["]"] = "[";

	keys["a"] = "'";
	keys["s"] = "a";
	keys["d"] = "s";
	keys["f"] = "d";
	keys["g"] = "f";
	keys["h"] = "g";
	keys["j"] = "h";
	keys["k"] = "j";
	keys["l"] = "k";
	keys[";"] = "l";
	keys["'"] = ";";

	keys["z"] = "/";
	keys["x"] = "z";
	keys["c"] = "x";
	keys["v"] = "c";
	keys["b"] = "v";
	keys["n"] = "b";
	keys["m"] = "n";
	keys[","] = "m";
	keys["."] = ",";
	keys["/"] = ".";

	keys["pause"] = "@qwr";

	return keys;
}

module.exports = {
	name: "games",
	keys: makeKeys(),
};
