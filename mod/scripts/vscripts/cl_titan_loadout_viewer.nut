global function AddTitanLoadoutIcons
global function PrintPlayerItemsCount


array<int> unique_passives = [
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

array<int> monarch_upgrades = [
	ePassives.PAS_VANGUARD_CORE1,
	ePassives.PAS_VANGUARD_CORE2,
	ePassives.PAS_VANGUARD_CORE3,
	ePassives.PAS_VANGUARD_CORE4,
	ePassives.PAS_VANGUARD_CORE5,
	ePassives.PAS_VANGUARD_CORE6,
	ePassives.PAS_VANGUARD_CORE7,
	ePassives.PAS_VANGUARD_CORE8,
	ePassives.PAS_VANGUARD_CORE9
]

table<string, float> last_print_time

int function AddTitanLoadoutIcons(entity player, var rui, int index)
{
	if (GetConVarBool("titanloadoutviewer_enable"))
	{
        if (IsValid( player ) && player.IsPlayer() && IsAlive(player))
        {
            if (player.IsTitan())
            {
                return AddTitanLoadoutIconsInternal(player, rui, index)
            }
            else if (player.GetPetTitan() != null)
            {
                return index // TODO deal with pet titan
            }
        }
	}
    return index
}

int function AddTitanLoadoutIconsInternal(entity player, var rui, int index)
{
    foreach(passive in unique_passives)
    {
        if (player.HasPassive(passive))
        {
            string passiveRef = PassiveEnumFromBitfield(passive)
            RuiSetImage(rui, "extraIcon" + index, GetItemImage(passiveRef))
            index++
            break
        }
    }
    foreach(passive in general_passives)
	{
        if (player.HasPassive(passive))
		{
            string passiveRef = PassiveEnumFromBitfield(passive)
            RuiSetImage(rui, "extraIcon" + index, GetItemImage(passiveRef))
            index++
            break
        }
    }
    return index
}

void function PrintPlayerItemsCount( entity player ) {
    if (!GetConVarBool("titanloadoutviewer_print_fd_items_count"))
        return

    if (!IsValid( player ) || !player.IsPlayer())
        return

    float cur_time = Time()
    string player_name = player.GetPlayerName()
    if (!ShouldPrintInfo(player_name, cur_time))
        return

    last_print_time[player_name] <- cur_time
    int numTurrets = player.GetPlayerNetInt( "burn_numTurrets" )
    int numShieldBoosts = player.GetPlayerNetInt( "numHarvesterShieldBoost" )
    int numCoreOverload = player.GetPlayerNetInt( "numSuperRodeoGrenades" )

    printt("----------------")
    printt(player_name)
    printt(format("Turrets: %i", numTurrets))
    printt(format("Shield Boosts: %i", numShieldBoosts))
    printt(format("Nuke Rodeos: %i", numCoreOverload))

    if (player.IsTitan() && IsAlive(player))
    {
        entity titan = player
        if (GetTitanClass(titan) == "vanguard")
        {
            foreach (core in monarch_upgrades) {
                if(player.HasPassive(core))
                {
                    string passiveRef = PassiveEnumFromBitfield(core)
                    printt(Localize(GetItemName(passiveRef)))
                }
            }
        }
    }
    printt("----------------")
}

bool function ShouldPrintInfo( string player_name, float cur_time )
{
    if (!(player_name in last_print_time))
    {
        return true
    }
    else
    {
        return cur_time - last_print_time[player_name] > 5.0
    }
    unreachable
}

string function GetTitanClass( entity titan )
{
	entity soul = titan.GetTitanSoul()
	string settingsName = PlayerSettingsIndexToName( soul.GetPlayerSettingsNum() )

	return expect string( Dev_GetPlayerSettingByKeyField_Global( settingsName, "titanCharacterName" ) )
}
