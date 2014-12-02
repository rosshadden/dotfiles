var path = require('path'),
	loadGruntConfig = require('load-grunt-config');

module.exports = function(grunt) {
	loadGruntConfig(grunt, {
		init: true,
		configPath: path.join(__dirname, 'tasks/config')
	});

	grunt.loadTasks('tasks');
};
