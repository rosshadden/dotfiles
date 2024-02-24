export def main [] {
	let zoxide_completer = {|spans: list<string>|
		$spans | skip 1 | zoxide query -l $in | lines | where {|x| $x != $env.PWD}
	}

	let carapace_completer = {|spans: list<string>|
		carapace $spans.0 nushell $spans
			| from json
			| if ($in | default [] | where value =~ "^-.*ERR$" | is-empty) { $in } else { null }
	}

	let multiple_completer = {|spans: list<string>|
		# let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

		# let spans = (if $expanded_alias != null  {
		# 	# put the first word of the expanded alias first in the span
		# 	$spans | skip 1 | prepend ($expanded_alias | split row " ")
		# } else { $spans })

		match $spans.0 {
			z => $zoxide_completer
			zi => $zoxide_completer
			__zoxide_z => $zoxide_completer
			__zoxide_zi => $zoxide_completer
			git => $carapace_completer
			_ => $carapace_completer
		} | do $in $spans
	}

	{
		case_sensitive: false # set to true to enable case-sensitive completions
		quick: false	# set this to false to prevent auto-selecting completions when only one remains
		partial: true	# set this to false to prevent partial filling of the prompt
		algorithm: "prefix"	# prefix or fuzzy
		external: {
			enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
			max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options

			# completer: $multiple_completer
			# completer: $carapace_completer
			# completer: $zoxide_completer
		}
		# use_ls_colors: true # set this to true to enable file/path/directory completions using LS_COLORS
	}
}

# # Custom completions for external commands (those outside of Nushell)
# # Each completions has two parts: the form of the external command, including its flags and parameters
# # and a helper command that knows how to complete values for those flags and parameters
#
# ## git
#
# # branches
# def "nu-complete git branches" [] {
# 	^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
# }
#
# # remote branches
# def "nu-complete git branches remote" [] {
# 	^git branch -r | tail -n+2 | lines | each { |line| $line | str trim | str replace ' .+$' '' }
# 	# ^git branch -r | cut -c 3- | tail -n+2
# }
#
# # remotes
# def "nu-complete git remotes" [] {
# 	^git remote | lines | each { |line| $line | str trim }
# }
#
# # Download objects and refs from another repository
# export extern "git fetch" [
# 	repository?: string@"nu-complete git remotes" # name of the repository to fetch
# 	branch?: string@"nu-complete git branches" # name of the branch to fetch
# 	--all                                         # Fetch all remotes
# 	--append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
# 	--atomic                                      # Use an atomic transaction to update local refs.
# 	--depth: int                                  # Limit fetching to n commits from the tip
# 	--deepen: int                                 # Limit fetching to n commits from the current shallow boundary
# 	--shallow-since: string                       # Deepen or shorten the history by date
# 	--shallow-exclude: string                     # Deepen or shorten the history by branch/tag
# 	--unshallow                                   # Fetch all available history
# 	--update-shallow                              # Update .git/shallow to accept new refs
# 	--negotiation-tip: string                     # Specify which commit/glob to report while fetching
# 	--negotiate-only                              # Do not fetch, only print common ancestors
# 	--dry-run                                     # Show what would be done
# 	--write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
# 	--no-write-fetch-head                         # Do not write FETCH_HEAD
# 	--force(-f)                                   # Always update the local branch
# 	--keep(-k)                                    # Keep dowloaded pack
# 	--multiple                                    # Allow several arguments to be specified
# 	--auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
# 	--no-auto-maintenance                         # Don't run 'git maintenance' at the end
# 	--auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
# 	--no-auto-gc                                  # Don't run 'git maintenance' at the end
# 	--write-commit-graph                          # Write a commit-graph after fetching
# 	--no-write-commit-graph                       # Don't write a commit-graph after fetching
# 	--prefetch                                    # Place all refs into the refs/prefetch/ namespace
# 	--prune(-p)                                   # Remove obsolete remote-tracking references
# 	--prune-tags(-P)                              # Remove any local tags that do not exist on the remote
# 	--no-tags(-n)                                 # Disable automatic tag following
# 	--refmap: string                              # Use this refspec to map the refs to remote-tracking branches
# 	--tags(-t)                                    # Fetch all tags
# 	--recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
# 	--jobs(-j): int                               # Number of parallel children
# 	--no-recurse-submodules                       # Disable recursive fetching of submodules
# 	--set-upstream                                # Add upstream (tracking) reference
# 	--submodule-prefix: string                    # Prepend to paths printed in informative messages
# 	--upload-pack: string                         # Non-default path for remote command
# 	--quiet(-q)                                   # Silence internally used git commands
# 	--verbose(-v)                                 # Be verbose
# 	--progress                                    # Report progress on stderr
# 	--server-option(-o): string                   # Pass options for the server to handle
# 	--show-forced-updates                         # Check if a branch is force-updated
# 	--no-show-forced-updates                      # Don't check if a branch is force-updated
# 	-4                                            # Use IPv4 addresses, ignore IPv6 addresses
# 	-6                                            # Use IPv6 addresses, ignore IPv4 addresses
# 	--help                                        # Display this help message
# ]
#
# # Check out git branches and files
# export extern "git checkout" [
# 	...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
# 	--conflict: string                              # conflict style (merge or diff3)
# 	--detach(-d)                                    # detach HEAD at named commit
# 	--force(-f)                                     # force checkout (throw away local modifications)
# 	--guess                                         # second guess 'git checkout <no-such-branch>' (default)
# 	--ignore-other-worktrees                        # do not check if another worktree is holding the given ref
# 	--ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
# 	--merge(-m)                                     # perform a 3-way merge with the new branch
# 	--orphan: string                                # new unparented branch
# 	--ours(-2)                                      # checkout our version for unmerged files
# 	--overlay                                       # use overlay mode (default)
# 	--overwrite-ignore                              # update ignored files (default)
# 	--patch(-p)                                     # select hunks interactively
# 	--pathspec-from-file: string                    # read pathspec from file
# 	--progress                                      # force progress reporting
# 	--quiet(-q)                                     # suppress progress reporting
# 	--recurse-submodules: string                    # control recursive updating of submodules
# 	--theirs(-3)                                    # checkout their version for unmerged files
# 	--track(-t)                                     # set upstream info for new branch
# 	-b: string                                      # create and checkout a new branch
# 	-B: string                                      # create/reset and checkout a branch
# 	-l                                              # create reflog for new branch
# 	--help                                          # Display this help message
# ]
#
# # Push changes
# export extern "git push" [
# 	remote?: string@"nu-complete git remotes",      # the name of the remote
# 	...refs: string@"nu-complete git branches"      # the branch / refspec
# 	--all                                           # push all refs
# 	--atomic                                        # request atomic transaction on remote side
# 	--delete(-d)                                    # delete refs
# 	--dry-run(-n)                                   # dry run
# 	--exec: string                                  # receive pack program
# 	--follow-tags                                   # push missing but relevant tags
# 	--force-with-lease: string                      # require old value of ref to be at this value
# 	--force(-f)                                     # force updates
# 	--ipv4(-4)                                      # use IPv4 addresses only
# 	--ipv6(-6)                                      # use IPv6 addresses only
# 	--mirror                                        # mirror all refs
# 	--no-verify                                     # bypass pre-push hook
# 	--porcelain                                     # machine-readable output
# 	--progress                                      # force progress reporting
# 	--prune                                         # prune locally removed refs
# 	--push-option(-o): string                       # option to transmit
# 	--quiet(-q)                                     # be more quiet
# 	--receive-pack: string                          # receive pack program
# 	--recurse-submodules: string                    # control recursive pushing of submodules
# 	--repo: string                                  # repository
# 	--set-upstream(-u)                              # set upstream for git pull/status
# 	--signed: string                                # GPG sign the push
# 	--tags                                          # push tags (can't be used with --all or --mirror)
# 	--thin                                          # use thin pack
# 	--verbose(-v)                                   # be more verbose
# 	--help                                          # Display this help message
# ]
#
# # chekout
# export extern "git co" [
# 	...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
# 	--conflict: string                              # conflict style (merge or diff3)
# 	--detach(-d)                                    # detach HEAD at named commit
# 	--force(-f)                                     # force checkout (throw away local modifications)
# 	--guess                                         # second guess 'git checkout <no-such-branch>' (default)
# 	--ignore-other-worktrees                        # do not check if another worktree is holding the given ref
# 	--ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
# 	--merge(-m)                                     # perform a 3-way merge with the new branch
# 	--orphan: string                                # new unparented branch
# 	--ours(-2)                                      # checkout our version for unmerged files
# 	--overlay                                       # use overlay mode (default)
# 	--overwrite-ignore                              # update ignored files (default)
# 	--patch(-p)                                     # select hunks interactively
# 	--pathspec-from-file: string                    # read pathspec from file
# 	--progress                                      # force progress reporting
# 	--quiet(-q)                                     # suppress progress reporting
# 	--recurse-submodules: string                    # control recursive updating of submodules
# 	--theirs(-3)                                    # checkout their version for unmerged files
# 	--track(-t)                                     # set upstream info for new branch
# 	-b: string                                      # create and checkout a new branch
# 	-B: string                                      # create/reset and checkout a branch
# 	-l                                              # create reflog for new branch
# 	--help                                          # Display this help message
# ]
#
# # change dir
# export extern "git cd" [
# 	...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
# 	--conflict: string                              # conflict style (merge or diff3)
# 	--detach(-d)                                    # detach HEAD at named commit
# 	--force(-f)                                     # force checkout (throw away local modifications)
# 	--guess                                         # second guess 'git checkout <no-such-branch>' (default)
# 	--ignore-other-worktrees                        # do not check if another worktree is holding the given ref
# 	--ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
# 	--merge(-m)                                     # perform a 3-way merge with the new branch
# 	--orphan: string                                # new unparented branch
# 	--ours(-2)                                      # checkout our version for unmerged files
# 	--overlay                                       # use overlay mode (default)
# 	--overwrite-ignore                              # update ignored files (default)
# 	--patch(-p)                                     # select hunks interactively
# 	--pathspec-from-file: string                    # read pathspec from file
# 	--progress                                      # force progress reporting
# 	--quiet(-q)                                     # suppress progress reporting
# 	--recurse-submodules: string                    # control recursive updating of submodules
# 	--theirs(-3)                                    # checkout their version for unmerged files
# 	--track(-t)                                     # set upstream info for new branch
# 	-b: string                                      # create and checkout a new branch
# 	-B: string                                      # create/reset and checkout a branch
# 	-l                                              # create reflog for new branch
# 	--help                                          # Display this help message
# ]
#
# # branch
# export extern "git b" [
# 	...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
# 	-d                                              # delet
# 	-r                                              # remot
# 	-h                                              # halp
# 	--help                                          # halp
# ]
#
# # rebase
# export extern "git rb" [
# 	...targets: string@"nu-complete git branches remote"   # name of the branch or files to checkout
# 	-d                                              # delet
# 	-h                                              # halp
# 	--help                                          # halp
# ]
