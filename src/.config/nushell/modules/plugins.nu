# systemd
# source ../plugins/systemd.nu

# zoxide
if ("../plugins/zoxide.nu" | path exists | not $in) {
	zoxide init nushell --cmd s | save --force ~/.config/nushell/plugins/zoxide.nu
}
source ../plugins/zoxide.nu
