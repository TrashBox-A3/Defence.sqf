



trg = createTrigger ["EmptyDetector", getPos obj1];
trg setTriggerArea [200, 50, 207, true];
trg setTriggerActivation ["EAST", "PRESENT", true];
trg setTriggerStatements ["this","hint '待ち伏せラインを突破されたぞ'","hint 'よし殺った'"];

private "_time";
_time = 300;


while {true} do {


  while {_time > 0} do {

if (triggerActivated trg) then {

	_time = _time - 1;
	hintSilent format["敵に突破されている!! \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
	sleep 1;

  if (_time <= 0) then {

    hint "もう無理だ";
    sleep 5;

      cuttext ["防ぎ切れなかった......","PLAIN",10];

      "Looser" call BIS_fnc_endMission;ForceEND;
  };

}

else

{

if ((!(triggerActivated trg))&&(_time < 120)) then {

  _time = _time + 1;
  hintSilent format["侵入者はいない \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
  sleep 1;
};

};

};
};
