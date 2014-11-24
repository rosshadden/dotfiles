var path = require('path'),
	loadGruntConfig = require('load-grunt-config');

module.exports = function(grunt) {
	loadGruntConfig(grunt, {
		configPath: path.join(process.cwd(), 'tasks/config')
	});

	grunt.loadTasks('tasks');
};
