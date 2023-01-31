// global function addLoadoutIcons
global function AddTitanLoadoutIcons

void function addLoadoutIcons(var rui, entity player)
{
	// printt("addLoadoutIcons")
	//RuiSetImage( rui, "extraIcon" + "0", $"r2_ui/menus/loadout_icons/primary_weapon/primary_softball" )

	for(int i = 0; i < 6; i++) //clearing extra icons
	{
		RuiSetImage( rui, "extraIcon" + i, $"" )
	}

	if(IsAlive(player))
	{

		entity soul = GetSoulFromPlayer(player)
		entity titan = null
		asset titanIcon
		int currentExtraIconIndex = 0

		if(player.IsTitan() && GetConVarInt("enable_titans_display") != 0)
		{
			titan = soul.GetTitan()
			//Logger.Info(GetTitanCharacterName(titan))
			titanIcon = GetIconForTitanClass(GetTitanCharacterName(titan))
			RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, titanIcon )
		}
		else
		{
			//Print order (reversed in game): Ordnance, tactical, weapon3, secondary, primary, titan
			asset weaponIcon
			asset tacticalIcon
			asset ordnanceIcon
			array <entity> weapons = player.GetMainWeapons()
			array <entity> offhand = player.GetOffhandWeapons()

			if(GetConVarInt("enable_ordnances_display") != 0 && offhand.len() > 0 && offhand[0] != null)
			{
				ordnanceIcon = GetWeaponInfoFileKeyFieldAsset_Global( offhand[0].GetWeaponClassName(), "hud_icon" )
				RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, ordnanceIcon )
			}
			if(GetConVarInt("enable_tacticals_display") != 0 && offhand.len() > 1 && offhand[1] != null)
			{
				tacticalIcon = GetWeaponInfoFileKeyFieldAsset_Global( offhand[1].GetWeaponClassName(), "hud_icon" )
				RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, tacticalIcon )
			}
			if(weapons.len() > 0)
			{
				for(int i = weapons.len(); i > 0; i--)
				{
					if(i == 1 && GetConVarInt("enable_primaries_display") != 0 || i > 1 && GetConVarInt("enable_secondaries_display") != 0)
					{
						weaponIcon = GetWeaponInfoFileKeyFieldAsset_Global( weapons[i-1].GetWeaponClassName(), "hud_icon" )
						RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, weaponIcon )
					}
				}
			}
			if(GetConVarInt("tlv_enable") != 0 && player.GetPetTitan() != null)
			{
				titan = soul.GetTitan()
				//Logger.Info(GetTitanCharacterName(titan))
				titanIcon = GetIconForTitanClass(GetTitanCharacterName(titan))
				RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, titanIcon )
			}
		}
	}
}

array<int> unique_passives =
[
	ePassives.PAS_RONIN_WEAPON,
	ePassives.PAS_NORTHSTAR_WEAPON,
	ePassives.PAS_ION_WEAPON,
	ePassives.PAS_TONE_WEAPON,
	ePassives.PAS_SCORCH_WEAPON,
	ePassives.PAS_LEGION_WEAPON,
	ePassives.PAS_ION_TRIPWIRE,
	ePassives.PAS_ION_VORTEX,
	ePassives.PAS_ION_LASERCANNON,
	ePassives.PAS_ION_WEAPON_ADS,
	ePassives.PAS_TONE_ROCKETS,
	ePassives.PAS_TONE_SONAR,
	ePassives.PAS_TONE_WALL,
	ePassives.PAS_TONE_BURST,
	ePassives.PAS_RONIN_ARCWAVE,
	ePassives.PAS_RONIN_PHASE,
	ePassives.PAS_RONIN_SWORDCORE,
	ePassives.PAS_RONIN_AUTOSHIFT,
	ePassives.PAS_NORTHSTAR_CLUSTER,
	ePassives.PAS_NORTHSTAR_TRAP,
	ePassives.PAS_NORTHSTAR_FLIGHTCORE,
	ePassives.PAS_NORTHSTAR_OPTICS,
	ePassives.PAS_SCORCH_FIREWALL,
	ePassives.PAS_SCORCH_SHIELD,
	ePassives.PAS_SCORCH_SELFDMG,
	ePassives.PAS_SCORCH_FLAMECORE,
	ePassives.PAS_LEGION_SPINUP,
	ePassives.PAS_LEGION_GUNSHIELD,
	ePassives.PAS_LEGION_SMARTCORE,
	ePassives.PAS_LEGION_SIEGE,
	ePassives.PAS_LEGION_CHARGESHOT,
	ePassives.PAS_VANGUARD_COREMETER,
	ePassives.PAS_VANGUARD_SHIELD,
	ePassives.PAS_VANGUARD_REARM,
	ePassives.PAS_VANGUARD_DOOM
]

array<int> general_passives = [
	ePassives.PAS_BUILD_UP_NUCLEAR_CORE,
	ePassives.PAS_HYPER_CORE,
	ePassives.PAS_ENHANCED_TITAN_AI,
	ePassives.PAS_ANTI_RODEO,
	ePassives.PAS_MOBILITY_DASH_CAPACITY,
	ePassives.PAS_AUTO_EJECT
]


void function AddTitanLoadoutIcons( entity player, var rui) {
	if( player.IsTitan() )
	{
		entity soul = player.GetTitanSoul()
		printt(player.GetPlayerName())
		foreach ( passive in general_passives )
		{
			if ( player.HasPassive( passive ) )
			{
				// RuiSetImage( rui, "extraIcon" + 4, GetItemImage( PassiveEnumFromBitfield( passive ) ) )
				printt(PassiveEnumFromBitfield( passive ))

				printt(Localize( GetItemName( PassiveEnumFromBitfield( passive ) ) ))
				break
			}
		}
		foreach ( passive in unique_passives )
		{
			if ( player.HasPassive( passive ) )
			{
				// RuiSetImage( rui, "extraIcon" + 5, GetItemImage( PassiveEnumFromBitfield( passive ) ) )
				printt(PassiveEnumFromBitfield( passive ))
				printt(Localize( GetItemName( PassiveEnumFromBitfield( passive ) ) ))
				break
			}
		}
		printt("------------------------------")
		string kit1 = string( player.GetPersistentVar( "activeTitanLoadout.passive1" ) )
		string kit2 = string( player.GetPersistentVar( "activeTitanLoadout.passive2" ) )
		printt(kit1)
		printt(kit2)
		printt("------------------------------")

	}
	else
	{
		// TODO get pet titan
	}

}

// int statusIndex = ePlayerStatusType.PTS_TYPE_NONE
// entity titan
// if ( teamPlayer.GetPetTitan() )
// 	titan = teamPlayer.GetPetTitan()
// else if ( teamPlayer.IsTitan() )
// 	titan = teamPlayer

// entity playerParent = teamPlayer.GetParent()
// bool playerIsInDropship = playerParent != null && IsDropship( playerParent )

// if ( playerIsInDropship && ( GetWaveSpawnType() == eWaveSpawnType.DROPSHIP || GetGameState() == eGameState.Epilogue ) )
// {
// 	statusIndex = ePlayerStatusType.PTS_TYPE_EVAC
// }
// else if ( titan && titan.GetTitanSoul() )
// {
// 	if ( !teamPlayer.IsTitan() )
// 	{
// 		if ( IsAlive( teamPlayer ) )
// 			statusIndex = ePlayerStatusType.PTS_TYPE_PILOT_TITAN
// 		else
// 			statusIndex = ePlayerStatusType.PTS_TYPE_DEAD_PILOT_TITAN
// 	}
// 	else
// 	{
// 		if ( !IsAlive( teamPlayer ) )

void function addTitanLoadoutIcons(entity player, var rui) {
	// TitanLoadoutDef loadout = GetActiveTitanLoadout( player )
	// printt(player.GetPlayerNameWithClanTag())

	// string kit1 = string( player.GetPersistentVar( "activeTitanLoadout.passive1" ) )
	// string kit2 = string( player.GetPersistentVar( "activeTitanLoadout.passive2" ) )
	// int kitIndex = GetItemIndexOfTypeByRef( GetItemType( kit1 ), kit1 )
	// int kitIndex2 = GetItemIndexOfTypeByRef( GetItemType( kit2 ), kit2 )


	// string titanRef = GetItemRefOfTypeByIndex( eItemTypes.TITAN, suitIndex )

	// var dataTable = GetDataTable( $"datatable/titan_properties.rpak" )
	// int row = GetDataTableRowMatchingStringValue( dataTable, GetDataTableColumnByName( dataTable, "titanRef" ), titanRef )
	// string setFile = GetDataTableString( dataTable, row, GetDataTableColumnByName( dataTable, "setFile" ) )

	// string kitRef = GetItemRefOfTypeByIndex( GetTitanLoadoutPropertyPassiveType( setFile, "passive1" ), kitIndex )
	// string kit2Ref = GetItemRefOfTypeByIndex( GetTitanLoadoutPropertyPassiveType( setFile, "passive2" ), kitIndex2 )
	int loadoutIndex = GetPersistentSpawnLoadoutIndex( player, "titan" )
	// int loadoutIndex = player.GetPlayerNetInt( "activeTitanLoadoutIndex" )

	RuiSetImage( rui, "extraIcon" + 4, GetItemImage( GetValidatedPersistentLoadoutValue( player, "titan", loadoutIndex, "passive1" ) ) )
	RuiSetImage( rui, "extraIcon" + 5, GetItemImage( GetValidatedPersistentLoadoutValue( player, "titan", loadoutIndex, "passive2" ) ) )
	if(player.IsTitan())
	{
		entity soul = GetSoulFromPlayer(player)
		entity titan = null
		titan = soul.GetTitan()
		printt(titan.GetPlayerSettings())
		// titanIcon = GetIconForTitanClass(GetTitanCharacterName(titan))
		// RuiSetImage( rui, "extraIcon" + currentExtraIconIndex++, titanIcon )
	}
}

