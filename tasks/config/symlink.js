module.exports = {

	options: {
		overwrite: true
	},

	main: {
		files: [{
			expand: true,
			cwd: 'dist/',
			src: ['*', '!.cvimrc', '!.vromerc'],
			dest: process.env.HOME + '/',
			dot: true,
			filter: 'isFile',
		}, {
			expand: true,
			cwd: 'dist/',
			src: ['.vim', '.vifm'],
			dest: process.env.HOME + '/',
			dot: true,
		}]
	},

	config: {
		expand: true,
		cwd: 'dist/.config',
		src: ['*'],
		dest: process.env.HOME + '/.config/',
	}

};
