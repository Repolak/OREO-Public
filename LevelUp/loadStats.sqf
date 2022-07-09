_playerStaminaLevel = profileNameSpace getVariable "playerStaminaLevel";
if (isNil "_playerStaminaLevel") then {
  profileNameSpace setVariable ["playerStaminaLevel", 1];
  _playerStaminaLevel = 1;
};
if (_playerStaminaLevel > 1) then {
  staminaAdjust = (1 - (0.05 * _playerStaminaLevel)) + 0.05;
  player setUnitTrait ["loadCoef",staminaAdjust,true];
};
_playerShotLevel = profileNameSpace getVariable "playerShotLevel";
if (isNil "_playerShotLevel") then {
  profileNameSpace setVariable ["playerShotLevel", 1];
  _playerShotLevel = 1;
};
if (_playerShotLevel > 1) then {
    ShotAdjust = 1 - (0.05 * _playerShotLevel);
    player setCustomAimCoef ShotAdjust;
};
