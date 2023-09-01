export-env {
	$env.PATH = (
		$env.PATH
		| prepend [
			# personal
			"~/bin",
			"~/local/bin",
			"~/.local/bin",

			# domain
			"~/dev/bin",
			"~/dev/candidatelabs/bin",
		]
		| append [
			# system
			"/usr/local/bin",
			"/usr/local/sbin",
			"/usr/sbin",
			"/opt/homebrew/bin",

			# lang
			"~/.nimble/bin",
			"~/.bun/bin",
			"~/.cargo/bin",
			"~/go/bin",
			"~/.rvm/bin",
			"~/.gem/ruby/3.0.0/bin",
			"/usr/bin/core_perl",
			"/usr/lib/jvm/java-7-openjdk/jre/bin",
		]
	)
}
