# load env variables
load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" && name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

# add dynamic fnm path
let-env PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

# add fnm with cd
def-env fnmcd [path: string] {
	let-env PWD = ($path | path expand)
	if (['.node-version' '.nvmrc'] | any? ($env.PWD | path join $it | path exists)) {
		fnm use --silent-if-unchanged
	}
}

# alias cd = fnmcd
