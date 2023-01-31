global function TitanLoadoutViewerSettings

void function TitanLoadoutViewerSettings()
{
	AddModTitle("Titan Loadout Viewer")

	// General
	AddModCategory("General")

	AddConVarSettingEnum("titanloadoutviewer_enable", "Enable ", [ "No", "Yes" ])
}