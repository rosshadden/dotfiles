const qwerty = require("./qwerty.json");

function makeKeys() {
	const keys = qwerty.keys;

	keys["q"] = "'";
	keys["w"] = ",";
	keys["e"] = ".";
	keys["r"] = "p";
	keys["t"] = "y";
	keys["y"] = "f";
	keys["u"] = "g";
	keys["i"] = "c";
	keys["o"] = "r";
	keys["p"] = "l";
	keys["["] = "/";
	keys["]"] = "=";

	keys["a"] = "a";
	keys["s"] = "o";
	keys["d"] = "e";
	keys["f"] = "u";
	keys["g"] = "i";
	keys["h"] = "d";
	keys["j"] = "h";
	keys["k"] = "t";
	keys["l"] = "n";
	keys[";"] = "s";
	keys["'"] = "-";

	keys["z"] = ";";
	keys["x"] = "q";
	keys["c"] = "j";
	keys["v"] = "k";
	keys["b"] = "x";
	keys["n"] = "b";
	keys["m"] = "m";
	keys[","] = "w";
	keys["."] = "v";
	keys["/"] = "z";

	keys["-"] = "[";
	keys["="] = "]";

	keys["pause"] = "@gam";

	return keys;
}

module.exports = {
	name: "dvorak",
	keys: makeKeys(),
};
