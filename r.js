#!/usr/bin/env node

var sys = require('sys'),
	exec = require('child_process').exec;

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
