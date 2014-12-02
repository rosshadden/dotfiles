module.exports = {

	options: {
		overwrite: true
	},

	main: {
		files: [{
			expand: true,
			cwd: 'src/',
			src: ['*', '!.cvimrc', '!.vromerc'],
			dest: process.env.HOME + '/',
			dot: true,
			filter: 'isFile',
		}, {
			expand: true,
			cwd: 'src/',
			src: ['bin', 'lib', '.vim', '.vifm'],
			dest: process.env.HOME + '/',
			dot: true,
		}]
	},

	config: {
		expand: true,
		cwd: 'src/.config',
		src: ['*'],
		dest: process.env.HOME + '/.config/',
	}

};
