// Wait until player is initialized
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};



//Init UPSMON script
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";

enableEngineArtillery false;


// TFR mod configuration
#include "\task_force_radio\functions\common.sqf";

tf_give_personal_radio_to_regular_soldier = false;                  // all players have the same radio which can be edited
publicVariable "tf_give_personal_radio_to_regular_soldier";

tf_no_auto_long_range_radio = true;                                      // do not give TL's a long range backpack
publicVariable "tf_no_auto_long_range_radio";

tf_give_microdagr_to_soldier = false;                                     // do not give micro dagr players
publicVariable "tf_give_microdagr_to_soldier";

tf_same_sw_frequencies_for_side = true;                             // same SW freqs for each side
publicVariable "tf_same_sw_frequencies_for_side";

tf_same_lr_frequencies_for_side = true;                               // same LR freqs for each side
publicVariable "tf_same_lr_frequencies_for_side";

_settingsSwWest = false call TFAR_fnc_generateSwSettings;                          // pre define the SW freqs
_settingsSwWest set [2, ["100","200","300","400","500","600","700","800"]];
tf_freq_west = _settingsSwWest;
publicVariable "tf_freq_west";

_settingsLRWest = false call TFAR_fnc_generateLRSettings;                            // pre define the LR freqs
_settingsLRWest set [2, ["50","51","52","53","54","55","56","57","58"]];
tf_freq_west_lr = _settingsLRWest;
publicVariable "tf_freq_west_lr";

//////////////////////////
[] execVM "Fleeing.sqf";
/////////////////////////
[] execVM "med.sqf";

[] execVM "spawn_vc.sqf";





///ace3 Camping Lanterns carry///
_fnc_makeCarrayble = {
    params ["_object"];
    diag_log text format ["Making %1 [%2] Carrable", _object, typeOf _object];
    [_object, true, [0,0.5,1], 0] call ace_dragging_fnc_setCarryable;
};
["Land_Camping_Light_F", "init", _fnc_makeCarrayble, true, [], true] call CBA_fnc_addClassEventHandler;

/////////////////////////////////
enableSaving [false, false];

CH_fnc_removePrimary = {
	player removeWeapon (primaryWeapon player);
};

[] spawn {
	if !(isDedicated) then {
		waitUntil {!isNull player};
		if (local player) then {
			[] spawn CH_fnc_removePrimary;
			player addEventHandler ["Respawn",{[] spawn CH_fnc_removePrimary}];
		};
	};
};
