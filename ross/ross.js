#!/usr/bin/env node

var sys = require('sys'),
	exec = require('child_process').exec,
	program = require('commander');

var puts = function(error, stdout, stderr){
	if(stdout.length){
		sys.puts(stdout);
		sys.puts(stderr);
	}
};

var run = function(){
	var args = Array.prototype.slice.call(arguments);
	var handler = (typeof args[args.length - 1] === 'function') ? args.splice(-1, 1) : puts;
	args.forEach(function(arg, a){
		exec(arg, handler);
	});
	return run;
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
			run('rm ' + path + file);
			run('rm ' + '.' + path + file);
			path += '*/';
		}
	});

program
	.command('grails [version]')
	.description('Switch to a specified grails version.')
	.option('-c, --current', 'Print the current version.')
	.action(function(version){
		if(version){
			run('update-alternatives --set grails /usr/share/grails/' + version + '/bin/grails');
			console.log('Grails switched to ' + version + '.');
		}
		if(program.current){
			run('update-alternatives --get-selections | grep grails');
		}
	});


program
	.command('search <pattern> <path>')
	.description('Search files using RegEx.')
	.action(function(pattern, path){
		var expression = new RegExp(pattern);
		run('egrep ' + pattern + ' ' + path, function(){
			var args = Array.prototype.slice.call(arguments);
			console.log('response', args);
		});
	});

program.parse(process.argv);
