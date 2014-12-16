var shell = require('shelljs');


module.exports = function(grunt) {
	grunt.registerTask('install', function() {
		const HOME = process.env.HOME;

		// TODO: expose these variables and use them in zsh/bash
		let dirs = {
			omz: `${HOME}/.oh-my-zsh`,
			dots: `${HOME}/dotfiles`,
			db: `${HOME}/Dropbox`,
		};


		// submodules
		grunt.log.writeln('Initializing git submodules...');
		shell.exec('git submodule init');
		shell.exec('git submodule update');

		grunt.log.writeln('Creating symlinks...');
		// grunt.task.run('symlink');
	});
};
