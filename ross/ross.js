#!/usr/bin/env node

var sys = require('sys'),
	fs = require('fs'),
	exec = require('child_process').exec,
	program = require('commander'),
	Lazy = require('lazy');

var config = require("./config");

var puts = function(error, stdout, stderr) {
	if (stdout.length) {
		sys.puts(stdout);
	}
	if (stderr.length) {
		sys.puts(stderr);
	}
};

var run = function() {
	var args = Array.prototype.slice.call(arguments);
	var handler = (typeof args[args.length - 1] === 'function') ? args.splice(-1, 1)[0] : puts;
	args.forEach(function(arg, a) {
		exec(arg, handler);
	});
	return run;
};

program
	.version('0.0.1');

program
	.command('clean [levels]')
	.description('Clean up confliced dropbox files.')
	.action(function(levels) {
		levels = levels && +levels || 4;

		var file = '*conflicted\\ copy*';

		var i, path = '';
		for(i = 0; i < levels; i++) {
			run('rm ' + path + file);
			run('rm ' + '.' + path + file);
			path += '*/';
		}
	});

program
	.command('grails [version]')
	.description('Switch to a specified grails version.')
	.option('-g, --get', 'Print the current version.')
	.option("-s, --set [project]", "Set the version for a project.")
	.action(function(version) {
		if (!program.get && !program.set) {
			if (version) {
				if (!/^\d+\.\d+\.\d+$/.test(version)) {
					version = config.programs[version] || version;
				}
				run('update-alternatives --set grails /usr/share/grails/' + version + '/bin/grails');
				console.log("Grails switched to %s.", version);
			}
		}

		if (program.get) {
			run('update-alternatives --get-selections | grep grails');
		}

		if (program.set) {
			run('update-alternatives --get-selections | grep grails');
		}
	});


program
	.command('search <pattern> <path>')
	.description('Search files using RegEx.')
	.action(function(pattern, path) {
		var expression = new RegExp(pattern, 'gm');
		var command = 'egrep -n "' + pattern + '" ' + path;
		run(command, function(error, stdout, stderr) {
			var lines;
			if (stdout.length) {
				lines = stdout.split('\n');
				lines = lines.map(function(line, l) {
					var preamble = line.match(/^.+:\d+:/);
					if (preamble) {
						var offset = line.indexOf(preamble[0]);
						var rest = line.substr(offset);
						console.log('rest', rest);
						var matches = expression.exec(rest);
						if (matches) {
							return {
								preamble: preamble[0],
								matches: matches.slice(1, -2)
							};
						}
					}
					return {};
				});
				lines.forEach(function(line, l) {
					console.log(line);
				});
			}
		});
	});

program.parse(process.argv);
