global function TitanLoadoutViewerSettings

void function TitanLoadoutViewerSettings()
{
	AddModTitle("Titan Loadout Viewer")

	// General
	AddModCategory("General")

	AddConVarSettingEnum("titanloadoutviewer_enable", "Enable Icon Display", [ "No", "Yes" ])
	AddConVarSettingEnum("titanloadoutviewer_print_fd_items_count", "Print FD items count", [ "No", "Yes" ])

	// FD miscellaneous
	AddModCategory("FD UI Settings (Set before round starts)")
	AddConVarSettingEnum( "titanloadoutviewer_fd_force_hide_minimap", "Force hide minimap", [ "No", "Yes" ] )
	AddConVarSettingEnum( "titanloadoutviewer_fd_force_hide_hud_icon", "Force hide enemy icons on HUD", [ "No", "Yes" ] )
}