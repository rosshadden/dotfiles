let pluginsDir = ~/.config/nu/plugins

# zoxide
zoxide init nushell --cmd s --hook prompt | save ($"($pluginsDir)/zoxide.nu")
source ~/.config/nu/plugins/zoxide.nu
