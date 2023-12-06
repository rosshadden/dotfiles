# zoxide
const zoxide_plugin = "~/.config/nushell/plugins/zoxide.nu"
if ($zoxide_plugin | path exists | not $in) {
	zoxide init nushell | save --force $zoxide_plugin
}
source $zoxide_plugin

# systemd
# source ../plugins/systemd.nu
