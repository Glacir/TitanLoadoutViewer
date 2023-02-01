global function TitanLoadoutViewerSettings

void function TitanLoadoutViewerSettings()
{
	AddModTitle("Titan Loadout Viewer")

	// General
	AddModCategory("General")

	AddConVarSettingEnum("titanloadoutviewer_enable", "Enable Icon Display", [ "No", "Yes" ])
	AddConVarSettingEnum("titanloadoutviewer_print_fd_items_count", "Print FD items count", [ "No", "Yes" ])
}