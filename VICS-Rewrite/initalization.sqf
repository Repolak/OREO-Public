if !(isServer) exitWith {};
[] spawn {
  uiSleep 3;
  [] spawn vics_econ_cycleMain;
};
