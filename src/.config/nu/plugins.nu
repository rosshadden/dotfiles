let pluginsDir = ~/.config/nu/plugins

source ./plugins/systemd.nu

# zoxide
zoxide init nushell --cmd s --hook prompt | save ($"($pluginsDir)/zoxide.nu")
source ./plugins/zoxide.nu
