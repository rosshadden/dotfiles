#!/usr/bin/env node

var sys = require('sys'),
	exec = require('child_process').exec,
	program = require('commander');

var puts = function(error, stdout, stderr){
	if(stdout.length){
		sys.puts(stdout);
		sys.puts(stderr);
	}else{
		sys.puts('Success.');
	}
};

program
	.version('0.0.1');

program
	.command('clean [levels]')
	.description('Clean up confliced dropbox files.')
	.action(function(levels){
		levels = levels && +levels || 4;

		var file = '*conflicted\\ copy*';

		var i, path = '';
		for(i = 0; i < levels; i++){
			exec('rm ' + path + file, puts);
			exec('rm ' + '.' + path + file, puts);
			path += '*/';
		}
	});

program
	.command('grails [version]')
	.description('Switch to a specified grails version.')
	.option('-c, --current', 'Print the current version.')
	.action(function(version){
		if(version){
			exec('update-alternatives --set grails /usr/share/grails/' + version + '/bin/grails', puts);
		}
	});

program.parse(process.argv);
