// global function addLoadoutIcons
global function AddTitanLoadoutIcons


array < int > unique_passives = [
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

array < int > general_passives = [
    ePassives.PAS_BUILD_UP_NUCLEAR_CORE,
    ePassives.PAS_HYPER_CORE,
    ePassives.PAS_ENHANCED_TITAN_AI,
    ePassives.PAS_ANTI_RODEO,
    ePassives.PAS_MOBILITY_DASH_CAPACITY,
    ePassives.PAS_AUTO_EJECT
]


int function AddTitanLoadoutIcons(entity player, var rui, int index)
{
    if (player.IsTitan()) {
        return AddTitanLoadoutIconsInternal(player, rui, index)
    } else if () {
        // TODO get pet titan
    }
    return index
}

int function AddTitanLoadoutIconsInternal(entity soul, var rui, int index)
{
    foreach(passive in general_passives) {
        if (player.HasPassive(passive)) {
            string passiveRef = PassiveEnumFromBitfield(passive)
            RuiSetImage(rui, "extraIcon" + index, GetItemImage(passiveRef))
            index++
            break
        }
    }
    foreach(passive in unique_passives) {
        if (player.HasPassive(passive)) {
            string passiveRef = PassiveEnumFromBitfield(passive)
            RuiSetImage(rui, "extraIcon" + index, GetItemImage(passiveRef))
            index++
            break
        }
    }
    return index
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
