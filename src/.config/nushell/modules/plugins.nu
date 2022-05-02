# systemd
# source ~/.config/nushell/plugins/systemd.nu

# zoxide
if ("~/.config/nushell/plugins/zoxide.nu" | path exists | not $in) {
	zoxide init nushell --cmd s --hook prompt | save ~/.config/nushell/plugins/zoxide.nu
}
source ~/.config/nushell/plugins/zoxide.nu
