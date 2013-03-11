#!/usr/bin/env node

var sys = require('sys'),
	exec = require('child_process').exec,
	program = require('commander');

program
	.version('0.0.1');

program
	.command('clean [levels]')
	.description('Clean up confliced dropbox files.')
	.action(function(levels){
		levels = levels && +levels || 4;

		var puts = function(error, stdout, stderr){
			stdout.length && sys.puts(stdout);
			stderr.length && sys.puts(stderr) || sys.puts('Success.');
		};

		var levels = +process.argv[2] || 4;
		var file = '*conflicted\\ copy*';

		var i, path = '';
		for(var i = 0; i < levels; i++){
			exec('rm ' + path + file, puts);
			exec('rm ' + '.' + path + file, puts);
			path += '*/';
		}
	});
