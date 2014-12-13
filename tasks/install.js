var shell = require('shelljs');


module.exports = function(grunt) {
	grunt.registerTask('install', function() {
		const HOME = process.env.HOME;

		let dirs = {
			zsh: `${HOME}/.oh-my-zsh`,
			dots: `${HOME}/dotfiles`,
			db: `${HOME}/Dropbox`,
		};


		// submodules
		// shell.exec('git submodule init');
		// shell.exec('git submodule update');

		grunt.task.run('symlink');
	});
};
