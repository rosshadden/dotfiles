#!/usr/bin/env node

const process = require("process");

const sexp = require("./sexp.js");
const source = require("./modules/source.json");

// const keyboard = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-if01-event-kbd";

const handlers = {
	config(keyboard) {
		return sexp("defcfg", [
			"input", sexp("device-file", wrap(keyboard)),
			"output", sexp("uinput-sink", [
				wrap("Kmonad output"),
				wrap(`sleep 1 && setxkbmap -option compose:sclk;
					xmodmap -e 'keycode 131 = Hyper_L' -e 'remove Mod4 = Hyper_L' -e 'add Mod3 = Hyper_L'`),
			]),
			"fallthrough", true,
			"allow-cmd", true,
		]);
	},

	source() {
		const keys = [];
		for (const key of Object.keys(source.keys)) {
			keys.push(key);
		}

		return sexp("defsrc", [ ...keys ]);
	},

	alias(file) {
		const layer = require(file);

		const nodes = [];
		for (const [ key, node ] of Object.entries(layer.aliases)) {
			nodes.push(key, node);
		}

		return sexp("defalias", nodes);
	},

	layer(file) {
		const layer = require(file);

		const keys = [];
		for (const key of Object.keys(source.keys)) {
			const mapping = layer.keys[key];
			if (mapping !== undefined) source.keys[key] = mapping;
			keys.push(source.keys[key]);
		}

		return sexp("deflayer", [ layer.name, ...keys ]);
	},
}

function toSexp(tree) {
	if (Array.isArray(tree)) {
		const name = tree.shift();
		const args = tree.map((node) => {
			if (Array.isArray(node)) return sexp(node[0], node.slice(1));
			return node;
		});
		return sexp(name, args);
	} else if (typeof tree === "object") {
		for (const [ key, node ] of Object.entries(tree)) {
			console.log(key, node);
		}
		return sexp(name, args);
	} else {
		return tree;
	}
}

function wrap(value) {
	return `"${value}"`;
}

function main() {
	if (process.argv.length <= 2) {
		return console.log("Usage: kmonad.js <type> [file]");
	}

	const [ , , type, arg ] = process.argv;

	if (typeof handlers[type] !== "function") {
		return console.log(`Error. <type> should be one of: ${Object.keys(handlers).join(", ")}`);
	}

	return process.stdout.write(handlers[type](arg).toString() + "\n\n");
}

main();
