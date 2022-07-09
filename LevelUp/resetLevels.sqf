profileNameSpace setVariable ["playerStaminaCount", 0];
profileNameSpace setVariable ["playerStaminaLevel", 1];
profileNameSpace setVariable ["playerShotLevel", 1];
profileNameSpace setVariable ["playerShotCount", 0];
player setUnitTrait ["loadCoef",1,true];
player setCustomAimCoef 1;
_textToSend = format ["%1 reset their stats!",(name player)];
[_textToSend] remoteExec ["systemChat", 0];
