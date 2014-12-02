module.exports = {

	main: {
		expand: true,
		cwd: 'src/',
		src: ['**'],
		dest: 'dist/',
		dot: true,
	},

	config: {
		expand: true,
		cwd: 'src/.config',
		src: ['**'],
		dest: 'dist/.config',
		dot: true,
	}

};
