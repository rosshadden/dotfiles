let pluginsDir = ~/.config/nu/plugins

source ./plugins/systemd.nu

# zoxide
if ("./plugins/zoxide.nu" | path exists) {
} {
	zoxide init nushell --cmd s --hook prompt | save ./plugins/zoxide.nu
}
source ./plugins/zoxide.nu
