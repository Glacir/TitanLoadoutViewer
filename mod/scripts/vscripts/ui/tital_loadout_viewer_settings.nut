global function TitanLoadoutViewerSettings

void function TitanLoadoutViewerSettings()
{
	AddModTitle("Titan Loadout Viewer")

	// General
	AddModCategory("General")

	AddConVarSettingEnum("tlv_enable", "Enable display ", [ "No", "Yes" ])
}