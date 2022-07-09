class vicsMainMenuTabletPlayerUpdate
  {
    idd = 1999; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "call vics_menu_xpText; call vics_menu_playerNear; uiNamespace setVariable ['vics_MainMenu', _this select 0]"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      xpTxt,
      playerList,
      creditsAmnt,
      creditsBtn,
      playerExit,
      resetStats,
      homeBtn
    };
    controlsBackground[] = {
      tabletBGround,
      RscFrame_1801,
      RscFrame_1802
    };

  class tabletBGround: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tabletEmpty.paa";
  	x = 0.0565625 * safezoneW + safezoneX;
  	y = -0.215 * safezoneH + safezoneY;
  	w = 0.902344 * safezoneW;
  	h = 1.463 * safezoneH;
  };
  class homeBtn: RscShortcutButton
  {
  	idc = 1704;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
  	animTextureDefault = "";
  	animTextureFocused = "";
  	animTextureNormal = "";
  	animTextureOver = "";
  	animTexturePressed = "";
  	action = "closeDialog 1; createDialog 'vicsMainMenuTablet';";

  	x = 0.692947 * safezoneW + safezoneX;
  	y = 0.48548 * safezoneH + safezoneY;
  	w = 0.0198958 * safezoneW;
  	h = 0.0411112 * safezoneH;
  	tooltip = "Home"; //--- ToDo: Localize;
  };
  class xpTxt: RscStructuredText
  {
  	idc = 1100;

  	x = 0.340156 * safezoneW + safezoneX;
  	y = 0.313 * safezoneH + safezoneY;
  	w = 0.108281 * safezoneW;
  	h = 0.121 * safezoneH;
  };
  class playerList: RscListbox
  {
  	idc = 1500;
  	x = 0.54125 * safezoneW + safezoneX;
  	y = 0.313 * safezoneH + safezoneY;
  	w = 0.118594 * safezoneW;
  	h = 0.11 * safezoneH;
  };
  class creditsAmnt: RscEdit
  {
  	idc = 1400;
  	x = 0.546406 * safezoneW + safezoneX;
  	y = 0.434 * safezoneH + safezoneY;
  	w = 0.061875 * safezoneW;
  	h = 0.033 * safezoneH;
  };
  class creditsBtn: RscShortcutButton
  {
  	idc = 1700;
  	x = 0.613437 * safezoneW + safezoneX;
  	y = 0.434 * safezoneH + safezoneY;
  	w = 0.04125 * safezoneW;
  	h = 0.033 * safezoneH;
    action = "[] call vics_menu_transferCredits";
    text = "Transfer";
  };
  class playerExit: RscShortcutButton
  {
  	idc = 1701;
  	action = "closeDialog 0; [] call vics_ply_playerExit;";

  	text = "Player Exit"; //--- ToDo: Localize;
  	x = 0.453594 * safezoneW + safezoneX;
  	y = 0.313 * safezoneH + safezoneY;
  	w = 0.04125 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class resetStats: RscShortcutButton
  {
  	idc = 1702;
  	action = "execVM 'LevelUp\resetLevels.sqf'; player sideChat 'Stats reset!';";

  	text = "Reset Stats"; //--- ToDo: Localize;
  	x = 0.453594 * safezoneW + safezoneX;
  	y = 0.379 * safezoneH + safezoneY;
  	w = 0.04125 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class RscFrame_1801: RscFrame
  {
  	idc = 1801;

  	x = 0.329844 * safezoneW + safezoneX;
  	y = 0.302 * safezoneH + safezoneY;
  	w = 0.170156 * safezoneW;
  	h = 0.143 * safezoneH;
  };
  class RscFrame_1802: RscFrame
  {
  	idc = 1802;
  	x = 0.536094 * safezoneW + safezoneX;
  	y = 0.302 * safezoneH + safezoneY;
  	w = 0.134062 * safezoneW;
  	h = 0.176 * safezoneH;
  };
};


class vicsCommsCard
  {
    idd = 3356; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = ""; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
    };
    controlsBackground[] = {
      commsCard
    };

  class commsCard: RscPicture
  {
  	idc = 1200;
  	text = "vemItems\Data\commsCard.paa";
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.247 * safezoneH + safezoneY;
  	w = 0.185625 * safezoneW;
  	h = 0.506 * safezoneH;
  };
};


class vicsEmailClient
  {
    idd = 2288; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "uiNamespace setVariable ['vics_Email', _this select 0];"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      emailsList,
      foldersList,
      contactsList,
      summaryText,
      messageText
    };
    controlsBackground[] = {
      emailBackground
    };

    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT START (by CPT D. Repo, v1.063, #Bixyve)
    ////////////////////////////////////////////////////////

    class emailBackground: RscPicture
    {
    	idc = 1200;

    	text = "emailClient.paa";
      x = 0.283437 * safezoneW + safezoneX;
    	y = 0.214 * safezoneH + safezoneY;
    	w = 0.427969 * safezoneW;
    	h = 0.572 * safezoneH;
    };
    class emailsList: RscListbox
    {
    	idc = 1500;
    	x = 0.385531 * safezoneW + safezoneX;
    	y = 0.37262 * safezoneH + safezoneY;
    	w = 0.319688 * safezoneW;
    	h = 0.066 * safezoneH;
      colorText[] = {0,0,0,1};
      colorTextRight[] = {0,0,0,1};
    	colorDisabled[] = {1,1,1,0.25};
    	colorScrollbar[] = {0,0,0,1};
    	colorSelect[] = {0,0,0,1};
    	colorSelect2[] = {0,0,0,1};
    	colorSelectBackground[] = {0.95,0.95,0.95,1};
    	colorSelectBackground2[] = {1,1,1,0.5};
    	colorBackground[] = {0,0,0,0.3};
    };
    class foldersList: RscListbox
    {
    	idc = 1501;
    	x = 0.284366 * safezoneW + safezoneX;
    	y = 0.37042 * safezoneH + safezoneY;
    	w = 0.0979687 * safezoneW;
    	h = 0.088 * safezoneH;
    };
    class contactsList: RscListbox
    {
    	idc = 1502;
    	x = 0.285912 * safezoneW + safezoneX;
    	y = 0.47404 * safezoneH + safezoneY;
    	w = 0.0979687 * safezoneW;
    	h = 0.297 * safezoneH;
    };
    class summaryText: RscStructuredText
    {
    	idc = 1100;
    	x = 0.386562 * safezoneW + safezoneX;
    	y = 0.456 * safezoneH + safezoneY;
    	w = 0.314531 * safezoneW;
    	h = 0.055 * safezoneH;
      class Attributes
      {
        color = #000000;
        size = 0.64;
        shadow = false;
        shadowColor = "#ff0000";
      };
      shadow = 0;
      colorText[] = {0,0,0,1};
    };
    class messageText: RscStructuredText
    {
    	idc = 1101;
    	x = 0.386562 * safezoneW + safezoneX;
    	y = 0.511 * safezoneH + safezoneY;
    	w = 0.314531 * safezoneW;
    	h = 0.253 * safezoneH;
      class Attributes
      {
        color = #000000;
        size = 1.2;
        shadow = false;
        shadowColor = "#ff0000";
      };
      shadow = 0;
    };
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT END
    ////////////////////////////////////////////////////////

};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by CPT D. Repo, v1.063, #Fiperu)
////////////////////////////////////////////////////////

class tabletBGround: RscPicture
{
	idc = 1200;

	text = "tablet\tabletEmpty.paa";
	x = -23 * GUI_GRID_W + GUI_GRID_X;
	y = -20 * GUI_GRID_H + GUI_GRID_Y;
	w = 87.5 * GUI_GRID_W;
	h = 66.5 * GUI_GRID_H;
};
class homeBtn: RscShortcutButton
{
	idc = 1704;
	color[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	periodFocus = 0;
	period = 0;
	periodOver = 0;
	animTextureDefault = "";
	animTextureFocused = "";
	animTextureNormal = "";
	animTextureOver = "";
	animTexturePressed = "";
	action = "closeDialog 0; createDialog 'vicsMainMenuTablet';";

	x = 38.71 * GUI_GRID_W + GUI_GRID_X;
	y = 11.84 * GUI_GRID_H + GUI_GRID_Y;
	w = 1.92929 * GUI_GRID_W;
	h = 1.86869 * GUI_GRID_H;
	tooltip = "Home"; //--- ToDo: Localize;
};
class saveBtn: RscShortcutButton
{
	idc = 1701;
	text = "OREO Save"; //--- ToDo: Localize;
	x = 0.329844 * safezoneW + safezoneX;
	y = 0.346 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.033 * safezoneH;
};
class saveQuitBtn: RscShortcutButton
{
	idc = 1702;
	text = "OREO Save Quit"; //--- ToDo: Localize;
	x = 0.329844 * safezoneW + safezoneX;
	y = 0.401 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.033 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


class vicsMainMenuTabletAdmin
  {
    idd = 2005; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "uiNamespace setVariable ['vics_MainMenu', _this select 0];"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      homeBtn,
      saveBtn,
      saveQuitBtn
    };
    controlsBackground[] = {
      tabletBGround
    };

  class tabletBGround: RscPicture
  {
    idc = 1200;

    text = "tablet\tabletEmpty.paa";
    x = 0.0565625 * safezoneW + safezoneX;
    y = -0.215 * safezoneH + safezoneY;
    w = 0.902344 * safezoneW;
    h = 1.463 * safezoneH;
  };
  class homeBtn: RscShortcutButton
  {
    idc = 1704;
    color[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    periodFocus = 0;
    period = 0;
    periodOver = 0;
    animTextureDefault = "";
    animTextureFocused = "";
    animTextureNormal = "";
    animTextureOver = "";
    animTexturePressed = "";
    action = "closeDialog 0; createDialog 'vicsMainMenuTablet';";

    x = 0.692947 * safezoneW + safezoneX;
    y = 0.48548 * safezoneH + safezoneY;
    w = 0.0198958 * safezoneW;
    h = 0.0411112 * safezoneH;
    tooltip = "Home"; //--- ToDo: Localize;
  };
  class saveBtn: RscShortcutButton
  {
  	idc = 1701;
  	text = "OREO Save"; //--- ToDo: Localize;
  	x = 0.329844 * safezoneW + safezoneX;
  	y = 0.346 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.033 * safezoneH;
    action = "[] remoteExec ['vics_sys_save',2]; SystemChat 'Game State Saved.'";
  };
  class saveQuitBtn: RscShortcutButton
  {
  	idc = 1702;
  	text = "OREO Save Quit"; //--- ToDo: Localize;
  	x = 0.329844 * safezoneW + safezoneX;
  	y = 0.401 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.033 * safezoneH;
    action = "[] remoteExec ['vics_sys_saveQuit',2]; SystemChat 'Game State Saved. Goodbye.'";
  };
};

class vicsMainMenuTablet
  {
    idd = 1999; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "uiNamespace setVariable ['vics_MainMenu', _this select 0]; call vics_menu_InfoUpdate;"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      mapBtn,
      playerBtn,
      mainText,
      supportBtn,
      settingsBtn,
      homeBtn,
      mainMenuUpdateTxt,
      adminBtn
    };
    controlsBackground[] = {
      tabletBGround
    };


    class tabletBGround: RscPicture
    {
    	idc = 1200;

    	text = "tablet\tablet.paa";
    	x = 0.0565625 * safezoneW + safezoneX;
    	y = -0.215 * safezoneH + safezoneY;
    	w = 0.902344 * safezoneW;
    	h = 1.463 * safezoneH;
    };
    class mapBtn: RscShortcutButton
    {
    	idc = 1700;
    	color[] = {0,0,0,0};
    	colorBackgroundActive[] = {0,0,0,0};
    	colorFocused[] = {0,0,0,0};
    	periodFocus = 0;
    	period = 0;
    	periodOver = 0;
    	animTextureDefault = "";
    	animTextureFocused = "";
    	animTextureNormal = "";
    	animTextureOver = "";
    	animTexturePressed = "";

    	x = 0.323141 * safezoneW + safezoneX;
    	y = 0.32136 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.066 * safezoneH;
    	tooltip = "Map Options"; //--- ToDo: Localize;
    };
    class playerBtn: RscShortcutButton
    {
    	idc = 1701;
    	color[] = {0,0,0,0};
    	colorBackgroundActive[] = {0,0,0,0};
    	colorFocused[] = {0,0,0,0};
    	periodFocus = 0;
    	period = 0;
    	periodOver = 0;
    	animTextureDefault = "";
    	animTextureFocused = "";
    	animTextureNormal = "";
    	animTextureOver = "";
    	animTexturePressed = "";

    	x = 0.323141 * safezoneW + safezoneX;
    	y = 0.40452 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.066 * safezoneH;
    	tooltip = "Player Options"; //--- ToDo: Localize;
      action = "closeDialog 0; createDialog 'vicsMainMenuTabletPlayer';";
    };
    class supportBtn: RscShortcutButton
    {
    	idc = 1701;
    	color[] = {0,0,0,0};
    	colorBackgroundActive[] = {0,0,0,0};
    	colorFocused[] = {0,0,0,0};
    	periodFocus = 0;
    	period = 0;
    	periodOver = 0;
    	animTextureDefault = "";
    	animTextureFocused = "";
    	animTextureNormal = "";
    	animTextureOver = "";
    	animTexturePressed = "";

    	x = 0.323141 * safezoneW + safezoneX;
    	y = 0.49164 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.077 * safezoneH;
    	tooltip = "Support Requests"; //--- ToDo: Localize;
    };
    class settingsBtn: RscShortcutButton
    {
    	idc = 1701;
    	color[] = {0,0,0,0};
    	colorBackgroundActive[] = {0,0,0,0};
    	colorFocused[] = {0,0,0,0};
    	periodFocus = 0;
    	period = 0;
    	periodOver = 0;
    	animTextureDefault = "";
    	animTextureFocused = "";
    	animTextureNormal = "";
    	animTextureOver = "";
    	animTexturePressed = "";

    	x = 0.321078 * safezoneW + safezoneX;
    	y = 0.59086 * safezoneH + safezoneY;
    	w = 0.0479688 * safezoneW;
    	h = 0.0964445 * safezoneH;
    	tooltip = "Settings"; //--- ToDo: Localize;
      action = "closeDialog 1; createDialog 'vicsMainMenuTabletSettings';";
    };
    class mainText: RscStructuredText
    {
    	idc = 1100;
    	x = 0.520625 * safezoneW + safezoneX;
    	y = 0.324 * safezoneH + safezoneY;
    	w = 0.159844 * safezoneW;
    	h = 0.363 * safezoneH;
    };
    class homeBtn: RscShortcutButton
    {
    	idc = 1704;
    	x = 0.692917 * safezoneW + safezoneX;
    	y = 0.485407 * safezoneH + safezoneY;
    	w = 0.0198958 * safezoneW;
    	h = 0.0411111 * safezoneH;
      color[] = {0,0,0,0};
    	colorBackgroundActive[] = {0,0,0,0};
    	colorFocused[] = {0,0,0,0};
    	periodFocus = 0;
    	period = 0;
    	periodOver = 0;
    	animTextureDefault = "";
    	animTextureFocused = "";
    	animTextureNormal = "";
    	animTextureOver = "";
    	animTexturePressed = "";
    	tooltip = "Home"; //--- ToDo: Localize;
      action = "closeDialog 0; createDialog 'vicsMainMenuTablet';";
    };

    class mainMenuUpdateTxt: RscStructuredText
    {
    	idc = 1101;
    	x = 0.505156 * safezoneW + safezoneX;
    	y = 0.335 * safezoneH + safezoneY;
    	w = 0.185625 * safezoneW;
    	h = 0.363 * safezoneH;
    };
    class adminBtn: RscShortcutButton
    {
    	idc = 1705;
    	text = ""; //--- ToDo: Localize;
    	x = 0.484531 * safezoneW + safezoneX;
    	y = 0.478 * safezoneH + safezoneY;
    	w = 0.04125 * safezoneW;
    	h = 0.066 * safezoneH;
      color[] = {0,0,0,0};
      colorBackgroundActive[] = {0,0,0,0};
      colorFocused[] = {0,0,0,0};
      periodFocus = 0;
      period = 0;
      periodOver = 0;
      animTextureDefault = "";
      animTextureFocused = "";
      animTextureNormal = "";
      animTextureOver = "";
      animTexturePressed = "";
      action = "[] call vics_ply_adminMenu;";
    	tooltip = "Admin Menu"; //--- ToDo: Localize;
    };
};

class vicsMainMenuTabletSettings
  {
    idd = 1999; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "uiNamespace setVariable ['vics_MainMenu', _this select 0]; call vics_menu_settings;"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      uiSizeCombo,
      UITxt,
      wallpaperCombo,
      wallpaperTxt,
      homeBtn
    };
    controlsBackground[] = {
      tabletBGround
    };

  class tabletBGround: RscPicture
  {
    idc = 1200;

    text = "tablet\tabletEmpty.paa";
    x = 0.0565625 * safezoneW + safezoneX;
    y = -0.215 * safezoneH + safezoneY;
    w = 0.902344 * safezoneW;
    h = 1.463 * safezoneH;
  };
  class homeBtn: RscShortcutButton
  {
    idc = 1704;
    color[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    periodFocus = 0;
    period = 0;
    periodOver = 0;
    animTextureDefault = "";
    animTextureFocused = "";
    animTextureNormal = "";
    animTextureOver = "";
    animTexturePressed = "";
    action = "call vics_menu_settingsApply";

    x = 0.692947 * safezoneW + safezoneX;
    y = 0.48548 * safezoneH + safezoneY;
    w = 0.0198958 * safezoneW;
    h = 0.0411112 * safezoneH;
    tooltip = "Home"; //--- ToDo: Localize;
  };
  class uiSizeCombo: RscCombo
  {
    idc = 2100;
    x = 0.324687 * safezoneW + safezoneX;
    y = 0.346 * safezoneH + safezoneY;
    w = 0.0670312 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class UITxt: RscText
  {
    idc = 1000;
    text = "UI Size"; //--- ToDo: Localize;
    x = 0.340156 * safezoneW + safezoneX;
    y = 0.313 * safezoneH + safezoneY;
    w = 0.04125 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class wallpaperCombo: RscCombo
  {
  	idc = 2101;

  	x = 0.324687 * safezoneW + safezoneX;
  	y = 0.412 * safezoneH + safezoneY;
  	w = 0.0670311 * safezoneW;
  	h = 0.033 * safezoneH;
  };
  class wallpaperTxt: RscText
  {
  	idc = 1000;

  	text = "Cover"; //--- ToDo: Localize;
  	x = 0.338094 * safezoneW + safezoneX;
  	y = 0.38054 * safezoneH + safezoneY;
  	w = 0.04125 * safezoneW;
  	h = 0.033 * safezoneH;
  };
};

class vicsMainMenuTabletPlayer
{
  idd = 1999; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = "call vics_menu_xpText; call vics_menu_playerNear; uiNamespace setVariable ['vics_MainMenu', _this select 0]"; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    xpTxt,
    playerList,
    creditsAmnt,
    creditsBtn,
    playerExit,
    resetStats,
    homeBtn
  };
  controlsBackground[] = {
    tabletBGround,
    RscFrame_1801,
    RscFrame_1802
  };

class tabletBGround: RscPicture
{
  idc = 1200;

  text = "tablet\tabletEmpty.paa";
  x = 0.0565625 * safezoneW + safezoneX;
  y = -0.215 * safezoneH + safezoneY;
  w = 0.902344 * safezoneW;
  h = 1.463 * safezoneH;
};
class homeBtn: RscShortcutButton
{
  idc = 1704;
  color[] = {0,0,0,0};
  colorBackgroundActive[] = {0,0,0,0};
  colorFocused[] = {0,0,0,0};
  periodFocus = 0;
  period = 0;
  periodOver = 0;
  animTextureDefault = "";
  animTextureFocused = "";
  animTextureNormal = "";
  animTextureOver = "";
  animTexturePressed = "";
  action = "closeDialog 1; createDialog 'vicsMainMenuTablet';";

  x = 0.692947 * safezoneW + safezoneX;
  y = 0.48548 * safezoneH + safezoneY;
  w = 0.0198958 * safezoneW;
  h = 0.0411112 * safezoneH;
  tooltip = "Home"; //--- ToDo: Localize;
};
class xpTxt: RscStructuredText
{
  idc = 1100;

  x = 0.340156 * safezoneW + safezoneX;
  y = 0.313 * safezoneH + safezoneY;
  w = 0.108281 * safezoneW;
  h = 0.121 * safezoneH;
};
class playerList: RscListbox
{
  idc = 1500;
  x = 0.54125 * safezoneW + safezoneX;
  y = 0.313 * safezoneH + safezoneY;
  w = 0.118594 * safezoneW;
  h = 0.11 * safezoneH;
};
class creditsAmnt: RscEdit
{
  idc = 1400;
  x = 0.546406 * safezoneW + safezoneX;
  y = 0.434 * safezoneH + safezoneY;
  w = 0.061875 * safezoneW;
  h = 0.033 * safezoneH;
};
class creditsBtn: RscShortcutButton
{
  idc = 1700;
  x = 0.613437 * safezoneW + safezoneX;
  y = 0.434 * safezoneH + safezoneY;
  w = 0.04125 * safezoneW;
  h = 0.033 * safezoneH;
  action = "[] call vics_menu_transferCredits";
  text = "Transfer";
};
class playerExit: RscShortcutButton
{
  idc = 1701;
  action = "closeDialog 0; [] call vics_ply_playerExit;";

  text = "Player Exit"; //--- ToDo: Localize;
  x = 0.453594 * safezoneW + safezoneX;
  y = 0.313 * safezoneH + safezoneY;
  w = 0.04125 * safezoneW;
  h = 0.055 * safezoneH;
};
class resetStats: RscShortcutButton
{
  idc = 1702;
  action = "execVM 'LevelUp\resetLevels.sqf'; player sideChat 'Stats reset!';";

  text = "Reset Stats"; //--- ToDo: Localize;
  x = 0.453594 * safezoneW + safezoneX;
  y = 0.379 * safezoneH + safezoneY;
  w = 0.04125 * safezoneW;
  h = 0.055 * safezoneH;
};
class RscFrame_1801: RscFrame
{
  idc = 1801;

  x = 0.329844 * safezoneW + safezoneX;
  y = 0.302 * safezoneH + safezoneY;
  w = 0.170156 * safezoneW;
  h = 0.143 * safezoneH;
};
class RscFrame_1802: RscFrame
{
  idc = 1802;
  x = 0.536094 * safezoneW + safezoneX;
  y = 0.302 * safezoneH + safezoneY;
  w = 0.134062 * safezoneW;
  h = 0.176 * safezoneH;
};
};

class vicsMainMenuSupport
  {
    idd = 1999; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "uiNamespace setVariable ['vics_MainMenu', _this select 0]"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      homeBtn,
      SuppliesButton
    };
    controlsBackground[] = {
      tabletBGround
    };


  class tabletBGround: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tabletEmpty.paa";
  	x = 0.0565625 * safezoneW + safezoneX;
  	y = -0.215 * safezoneH + safezoneY;
  	w = 0.902344 * safezoneW;
  	h = 1.463 * safezoneH;
  };
  class homeBtn: RscShortcutButton
  {
  	idc = 1704;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
  	animTextureDefault = "";
  	animTextureFocused = "";
  	animTextureNormal = "";
  	animTextureOver = "";
  	animTexturePressed = "";
  	action = "closeDialog 0; createDialog 'vicsMainMenuTablet';";

  	x = 0.692947 * safezoneW + safezoneX;
  	y = 0.48548 * safezoneH + safezoneY;
  	w = 0.0198958 * safezoneW;
  	h = 0.0411112 * safezoneH;
  	tooltip = "Home"; //--- ToDo: Localize;
  };
  class SuppliesButton: RscShortcutButton
  {
  	idc = 1704;
  	action = "closeDialog 0; createDialog 'vicsTabletSuppliesRequest';";
  	text = "Supplies Request"; //--- ToDo: Localize;
  	x = 0.324687 * safezoneW + safezoneX;
  	y = 0.324 * safezoneH + safezoneY;
  	w = 0.0515625 * safezoneW;
  	h = 0.055 * safezoneH;
  	tooltip = "Home"; //--- ToDo: Localize;
  };
};

class vicsTabletSuppliesRequest
{
  idd = 1999; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = "uiNamespace setVariable ['vics_MainMenu', _this select 0]"; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    homeBtn
  };
  controlsBackground[] = {
    tabletBGround
  };

  class tabletBGround: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tabletEmpty.paa";
  	x = 0.0565625 * safezoneW + safezoneX;
  	y = -0.215 * safezoneH + safezoneY;
  	w = 0.902344 * safezoneW;
  	h = 1.463 * safezoneH;
  };
  class homeBtn: RscShortcutButton
  {
  	idc = 1704;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
  	animTextureDefault = "";
  	animTextureFocused = "";
  	animTextureNormal = "";
  	animTextureOver = "";
  	animTexturePressed = "";
  	action = "closeDialog 0; createDialog 'vicsMainMenuTablet';";

  	x = 0.692947 * safezoneW + safezoneX;
  	y = 0.48548 * safezoneH + safezoneY;
  	w = 0.0198958 * safezoneW;
  	h = 0.0411112 * safezoneH;
  	tooltip = "Home"; //--- ToDo: Localize;
  };
  class RscListbox_1500: RscListbox
  {
  	idc = 1500;
  	x = 0.340156 * safezoneW + safezoneX;
  	y = 0.324 * safezoneH + safezoneY;
  	w = 0.149531 * safezoneW;
  	h = 0.297 * safezoneH;
  };
  class RscStructuredText_1100: RscStructuredText
  {
  	idc = 1100;
  	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
  	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
  	w = 14 * GUI_GRID_W;
  	h = 0.25 * GUI_GRID_H;
  };
  class RscStructuredText_1101: RscStructuredText
  {
  	idc = 1101;
  	text = "body"; //--- ToDo: Localize;
  	x = 0.510311 * safezoneW + safezoneX;
  	y = 0.39 * safezoneH + safezoneY;
  	w = 0.134062 * safezoneW;
  	h = 0.154 * safezoneH;
  };
  class RscShortcutButton_1701: RscShortcutButton
  {
  	idc = 1701;
  	text = "Confirm Order"; //--- ToDo: Localize;
  	x = 0.340156 * safezoneW + safezoneX;
  	y = 0.632 * safezoneH + safezoneY;
  	w = 0.149531 * safezoneW;
  	h = 0.044 * safezoneH;
  };
  class RscSlider_1900: RscSlider
  {
  	idc = 1900;
  	text = "amountSlider"; //--- ToDo: Localize;
  	x = 0.494844 * safezoneW + safezoneX;
  	y = 0.632 * safezoneH + safezoneY;
  	w = 0.154687 * safezoneW;
  	h = 0.044 * safezoneH;
  };
  class fastDelivery: RscCheckbox
  {
  	idc = 2800;
  	x = 0.505156 * safezoneW + safezoneX;
  	y = 0.555 * safezoneH + safezoneY;
  	w = 0.04125 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class RscStructuredText_1102: RscStructuredText
  {
  	idc = 1102;
  	text = "amount"; //--- ToDo: Localize;
  	x = 0.551562 * safezoneW + safezoneX;
  	y = 0.555 * safezoneH + safezoneY;
  	w = 0.0928125 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class RscStructuredText_1103: RscStructuredText
  {
  	idc = 1103;
  	text = "name"; //--- ToDo: Localize;
  	x = 0.510312 * safezoneW + safezoneX;
  	y = 0.324 * safezoneH + safezoneY;
  	w = 0.134062 * safezoneW;
  	h = 0.055 * safezoneH;
  };
};


class vicsPlayerLockerMain
{
  idd = 8000; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = "_cam = player getVariable 'lockerCam'; _cam cameraEffect ['terminate','back']; camDestroy _cam;"; //code to run when its closed
  controls[] = {
    TBD1,
    TBD2,
    TBD3,
    Loadouts
  };

  controlsBackground[] = {

  };
  class TBD1: RscShortcutButton
  {
  	idc = 1701;
  	text = "TBD1"; //--- ToDo: Localize;
  	x = 0.388625 * safezoneW + safezoneX;
  	y = 0.929 * safezoneH + safezoneY;
  	w = 0.105187 * safezoneW;
  	h = 0.044 * safezoneH;
  };
  class Loadouts: RscShortcutButton
  {
  	idc = 1700;
  	text = "Loadouts"; //--- ToDo: Localize;
  	x = 0.264875 * safezoneW + safezoneX;
  	y = 0.929 * safezoneH + safezoneY;
  	w = 0.105187 * safezoneW;
  	h = 0.044 * safezoneH;
  };
  class TBD2: RscShortcutButton
  {
  	idc = 1702;
  	text = "TBD2"; //--- ToDo: Localize;
  	x = 0.512375 * safezoneW + safezoneX;
  	y = 0.929 * safezoneH + safezoneY;
  	w = 0.105187 * safezoneW;
  	h = 0.044 * safezoneH;
  };
  class TBD3: RscShortcutButton
  {
  	idc = 1703;
  	text = "TBD3"; //--- ToDo: Localize;
  	x = 0.636125 * safezoneW + safezoneX;
  	y = 0.929 * safezoneH + safezoneY;
  	w = 0.105187 * safezoneW;
  	h = 0.044 * safezoneH;
  };
};
































class vicsMainMenu
  {
    idd = 2001; //no need for the whole dialog to be referenced at any time.
    movingEnable = true; //not moving
    moving = 1; // who the hell knows what this does????????
    onLoad = "call vics_menu_xpText; call vics_menu_playerNear; uiNamespace setVariable ['vics_MainMenu', _this select 0]"; //code to run when it loads
    onUnload = ""; //code to run when its closed
    controls[] = {
      xpInfoTxt,
      saveStatsBtn,
      playerSaveBtn,
      playerResetBtn,
      resetStatsBtn,
      vicsStatsTxt,
      titleTxt,
      moneyList,
      moneyBtn,
      resetStatsChk,
      moneyAmnt,
      creditsTxt
    };
    controlsBackground[] = {
      backgroundMainMenu,
      RscFrame_1800,
      RscFrame_1801,
      RscFrame_1802
    };

    class backgroundMainMenu: IGUIBack
    {
    	idc = 2200;

    	x = -0.5625;
    	y = -0.24;
    	w = 2.0;
    	h = 1.52;
    };
    class xpInfoTxt: RscStructuredText
    {
    	idc = 1100;

    	x = 0.95;
    	y = 0.82;
    	w = 0.4625;
    	h = 0.44;
    };
    class saveStatsBtn: RscButton
    {
    	idc = 1600;

    	x = 0.9625;
    	y = 0.7;
    	w = 0.1875;
    	h = 0.1;
    };
    class playerSaveBtn: RscButton
    {
    	idc = 1602;
      text = "Player Save";
    	x = -0.5125;
    	y = 1.04;
    	w = 0.2;
    	h = 0.12;
    };
    class playerResetBtn: RscButton
    {
    	idc = 1603;
      text = "Player Reset";
    	x = -0.275;
    	y = 1.04;
    	w = 0.2;
    	h = 0.12;
    };
    class resetStatsBtn: RscButton
    {
    	idc = 1601;

    	x = 1.2125;
    	y = 0.7;
    	w = 0.1875;
    	h = 0.1;
    };
    class vicsStatsTxt: RscStructuredText
    {
    	idc = 1101;

      x = -0.5125;
    	y = 0;
    	w = 0.45;
    	h = 1.02;
    };
    class titleTxt: RscStructuredText
    {
    	idc = 1102;

    	x = -0.55;
    	y = -0.22;
    	w = 1.95;
    	h = 0.1;
    };
    class moneyList: RscListBox
    {
    	idc = 1500;

    	x = 0.8375;
    	y = -0.02;
    	w = 0.3125;
    	h = 0.5;
    };
    class moneyBtn: RscButton
    {
    	idc = 1604;
    	x = 1.175;
    	y = 0.12;
    	w = 0.2375;
    	h = 0.1;
      action = "[] call vics_menu_transferCredits";
    };
    class resetStatsChk: RscCheckBox
    {
    	idc = 2800;

    	x = 1.275;
    	y = 0.62;
    	w = 0.0625;
    	h = 0.06;
    };
    class moneyAmnt: RscEdit
    {
    	idc = 1400;
    	x = 1.175;
    	y = -0.02;
    	w = 0.2375;
    	h = 0.08;
    };
    class RscFrame_1800: RscFrame
    {
    	idc = 1800;
    	x = 0.9375;
    	y = 0.6;
    	w = 0.4875;
    	h = 0.68;
    };
    class RscFrame_1801: RscFrame
    {
    	idc = 1801;
    	x = 0.8125;
    	y = -0.04;
    	w = 0.6125;
    	h = 0.6;
    };
    class RscFrame_1802: RscFrame
    {
    	idc = 1802;
      x = -0.5375;
    	y = -0.02;
    	w = 0.4875;
    	h = 1.2;
    };

    class creditsTxt: RscText
    {
    	idc = 1003;
    	x = 1.175;
    	y = 0.26;
    	w = 0.225;
    	h = 0.08;
    };


  };







class vicsOxyBottleMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    oxyBottle,
    oxyTurnOn



  }; //anything that doesn't fit into the category below
  controlsBackground[] = {}; //backgrou
  class oxyBottle: RscPicture
  {
  	idc = 1200;
  	text = "oxyBottle.paa";
  	x = -0.525;
  	y = -0.4;
  	w = 1.9875;
  	h = 1.82;
  };
  class oxyTurnOn: RscShortcutButton
  {
  	idc = 1700;
  	x = 0.3875;
  	y = -0.24;
  	w = 0.0625;
  	h = 0.08;
    color[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    periodFocus = 0;
    period = 0;
    periodOver = 0;
    animTextureDefault = "";
    animTextureFocused = "";
    animTextureNormal = "";
    animTextureOver = "";
    animTexturePressed = "";
    action = "[] call vics_halo_maskBreathe";
  	tooltip = "Turn on/off oxygen"; //--- ToDo: Localize;
  };
};




class vicsDialog
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {vicsSave,vicsEraseButton}; //anything that doesn't fit into the category below
  controlsBackground[] = {vicsBackground}; //background things that can’t be interacted with

  ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Berajy)
////////////////////////////////////////////////////////

class vicsSave: RscButton
{
  idc = 1600;

  text = "Save Game"; //--- ToDo: Localize;
  x = 0.3375;
  y = 0.22;
  w = 0.2875;
  h = 0.2;
  colorBackground[] = {0.569,0.569,0.569,1};
  colorActive[] = {0.569,0.569,0.569,1};
  action = "closeDialog 0; [] call vics_sys_save;";
};
class vicsEraseButton: RscButton
{
  idc = 1601;
  action = "closeDialog 0; createDialog 'vicsEraseConfirm'";

  text = "Reset Save"; //--- ToDo: Localize;
  x = 0.3375;
  y = 0.54;
  w = 0.2875;
  h = 0.22;
  colorBackground[] = {0.569,0.569,0.569,1};
  colorActive[] = {0.569,0.569,0.569,1};
};
class vicsBackground: IGUIBack
{
  idc = 2200;

  x = 0.0125;
  y = 0.02;
  w = 0.975;
  h = 0.96;
  colorBackground[] = {0.231,0.231,0.231,1};
  colorActive[] = {0.231,0.231,0.231,1};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////





};


class vicsEraseConfirm
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {vicsConfirmEraseButton}; //anything that doesn't fit into the category below
  controlsBackground[] = {}; //background things that can’t be interacted with

    ////////////////////////////////////////////////////////
  	// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Buwaso)
  	////////////////////////////////////////////////////////

  	class vicsConfirmEraseButton: RscButton
  	{
  		idc = 1600;
  		text = "Are you sure? This cant be undone"; //--- ToDo: Localize;
  		x = 0.2875;
  		y = 0.34;
  		w = 0.375;
  		h = 0.3;
      colorBackground[] = {0.569,0.569,0.569,1};
      colorActive[] = {0.569,0.569,0.569,1};
      action = "closeDialog 0; execVM 'VICS\eraseSave.sqf'";
  	};
  	////////////////////////////////////////////////////////
  	// GUI EDITOR OUTPUT END
  	////////////////////////////////////////////////////////




};


class vicsDialogMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {vicsMainSave,levelUpMain,RBDMain,VicsWelcomeText}; //anything that doesn't fit into the category below
  controlsBackground[] = {vicsMainBackground}; //background things that can’t be interacted with
  ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Puwuso)
////////////////////////////////////////////////////////

class vicsMainSave: RscButton
{
	idc = 1600;
	action = "closeDialog 0; createDialog 'vicsDialog'";

	text = "V.I.C.S."; //--- ToDo: Localize;
	x = 0.3625;
	y = 0.2;
	w = 0.2875;
	h = 0.12;
	colorBackground[] = {0.929,0.929,0.929,0.7};
	colorActive[] = {0.929,0.929,0.929,0.7};
};
class levelUpMain: RscButton
{
	idc = 1601;
	action = "closeDialog 0; createDialog 'LevelUpDialogMain'";

	text = "LevelUp"; //--- ToDo: Localize;
	x = 0.3625;
	y = 0.34;
	w = 0.2875;
	h = 0.12;
	colorBackground[] = {0.929,0.929,0.929,0.7};
	colorActive[] = {0.929,0.929,0.929,0.7};
};
class RBDMain: RscButton
{
	idc = 1602;
	action = "closeDialog 0; createDialog 'RBDDialogMain'";

	text = "RBD"; //--- ToDo: Localize;
	x = 0.3625;
	y = 0.48;
	w = 0.2875;
	h = 0.12;
	colorBackground[] = {0.929,0.929,0.929,0.7};
	colorActive[] = {0.929,0.929,0.929,0.7};
};
class vicsMainBackground: IGUIBack
{
	idc = 2200;

	x = 0.1875;
	y = 0.1;
	w = 0.6375;
	h = 0.54;
	colorBackground[] = {0,0,0,0.75};
	colorActive[] = {0,0,0,0.75};
};
class VicsWelcomeText: RscText
{
	idc = 1000;
	font = "RobotoCondensedBold";

	text = "Welcome to The Dynamic Combat Project!"; //--- ToDo: Localize;
	x = 0.3125;
	y = 0.02;
	w = 0.375;
	h = 0.26;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
};

class LevelUpDialogMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {LevelUpSaveStats,LevelUpCheckStats,LevelUpResetStats}; //anything that doesn't fit into the category below
  controlsBackground[] = {LevelUpBackground}; //background things that can’t be interacted with

    class LevelUpSaveStats: RscButton
    {
    	idc = 1600;
    	text = "Save Stats"; //--- ToDo: Localize;
    	x = 0.0625;
    	y = 0.08;
    	w = 0.25;
    	h = 0.18;
      colorText[] = {1,1,1,1};
    	colorBackground[] = {0.569,0.569,0.569,1};
    	colorActive[] = {0.569,0.569,0.569,1};
      colorFocused[] = {0,0,0,1};
    	sizeEx = 0.04;
      action = "saveProfileNamespace; player sideChat 'Stats saved!'";
    };
    class LevelUpCheckStats: RscButton
    {
    	idc = 1601;
    	text = "toggle Stats"; //--- ToDo: Localize;
    	x = 0.375;
    	y = 0.08;
    	w = 0.25;
    	h = 0.18;
      colorText[] = {1,1,1,1};
    	colorBackground[] = {0.569,0.569,0.569,1};
    	colorActive[] = {0.569,0.569,0.569,1};
      colorFocused[] = {0,0,0,1};
    	sizeEx = 0.04;
      action = "if (toggleMenu == 0) then {toggleMenu = 1} else {toggleMenu = 0}";
    };
    class LevelUpResetStats: RscButton
    {
    	idc = 1602;
    	text = "Reset Stats"; //--- ToDo: Localize;
    	x = 0.7;
    	y = 0.08;
    	w = 0.25;
    	h = 0.18;
      colorText[] = {1,1,1,1};
    	colorBackground[] = {0.569,0.569,0.569,1};
    	colorActive[] = {0.569,0.569,0.569,1};
      colorFocused[] = {0,0,0,1};
    	sizeEx = 0.04;
      action = "execVM 'LevelUp\resetLevels.sqf'; player sideChat 'Stats reset!';";
    };
    class LevelUpBackground: IGUIBack
    {
      idc = 2200;
      x = 0;
      y = 0;
      w = 1.0125;
      h = 0.98;
      colorText[] = {1,1,1,1};
      colorBackground[] = {0.231,0.231,0.231,1};
      colorActive[] = {0.231,0.231,0.231,1};
    };
    ////////////////////////////////////////////////////////
    // GUI EDITOR OUTPUT END
    ////////////////////////////////////////////////////////

};



class RBDDialogMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {sandbagSmall,sandbagLarge,plank4m,HBarrierSmall,HBarrier_corridor,ammoBoxSmall}; //anything that doesn't fit into the category below
  controlsBackground[] = {RBDBackground}; //background things that can’t be interacted with

  class sandbagSmall: RscButton
  {
    text = "sandbag (small)";
  	idc = 1600;
  	x = 0.0375;
  	y = 0.04;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEx = 0.03;
    action = "closeDialog 0; ['Land_BagFence_Short_F'] call RBD_fnc_object";
  };
  class sandbagLarge: RscButton
  {
  	idc = 1601;
    text = "sandbag (large)";
  	x = 0.225;
  	y = 0.04;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEx = 0.03;
    action = "closeDialog 0; ['Land_BagFence_Long_F'] call RBD_fnc_object";
  };
  class plank4m: RscButton
  {
  	idc = 1602;
    text = "Plank(4m)";
  	x = 0.425;
  	y = 0.04;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEx = 0.04;
    action = "closeDialog 0; ['Land_Plank_01_4m_F'] call RBD_fnc_object";
  };
  class HBarrierSmall: RscButton
  {
  	idc = 1603;
    text = "H Barrier (3)";
  	x = 0.625;
  	y = 0.04;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEx = 0.03;
    action = "closeDialog 0; ['Land_HBarrier_3_f'] call RBD_fnc_object";
  };
  class HBarrier_corridor: RscButton
  {
  	idc = 1604;
    text = "H Barrier Corridor";
  	x = 0.825;
  	y = 0.04;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEx = 0.03;
    action = "closeDialog 0; ['Land_HBarrierWall_corridor_F'] call RBD_fnc_object";
  };
  class ammoBoxSmall: RscButton
  {
  	idc = 1605;
    text = "Ammo box";
  	x = 0.0375;
  	y = 0.22;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
    sizeEX = 0.04;
    action = "closeDialog 0; ['Box_NATO_Ammo_F'] call RBD_fnc_object";
  };
  class RscButton_1606: RscButton
  {
  	idc = 1606;
  	x = 0.225;
  	y = 0.22;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
  };
  class RscButton_1607: RscButton
  {
  	idc = 1607;
  	x = 0.425;
  	y = 0.22;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
  };
  class RscButton_1608: RscButton
  {
  	idc = 1608;
  	x = 0.625;
  	y = 0.22;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
  };
  class RscButton_1609: RscButton
  {
  	idc = 1609;
  	x = 0.825;
  	y = 0.22;
  	w = 0.15;
  	h = 0.14;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.569,0.569,0.569,1};
    colorActive[] = {0.569,0.569,0.569,1};
  };
  class RBDBackground: IGUIBack
  {
    idc = 2200;
    x = 0;
    y = 0;
    w = 1.0125;
    h = 0.98;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.231,0.231,0.231,1};
    colorActive[] = {0.231,0.231,0.231,1};
  };
};



class civInteractMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = "[target,interactor] remoteExec ['civ_fnc_ConversationStart',2]; [""all""] call civ_fnc_InteractQuestionsPop;"; //code to run when it loads
  onUnload = "[target] remoteExec ['civ_fnc_ConversationEnd',2];"; //code to run when its closed
  controls[] = {
    civInteractGreetings,
    civInteractQuestions,
    civInteractCivilan,
    civInteractHostile,
    civInteract5,
    civInteractActions,
    GreetingAction1,
    GreetingAction2,
    GreetingAction3,
    GreetingAction4,
    GreetingAction5,
    GreetingAction6,
    GreetingAction7,
    GreetingAction8,
    GreetingAction9,
    GreetingAction10,
    GreetingAction11,
    GreetingAction12,
    GreetingAction13,
    GreetingAction14

  }; //anything that doesn't fit into the category below
  controlsBackground[] = {civInteractMainBack}; //background things that can’t be interacted with


  ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Darehu)
////////////////////////////////////////////////////////

  class civInteractMainBack: IGUIBack
  {
  	idc = 2200;

    x = 0.2525 * safezoneW + safezoneX;
    y = 0.258 * safezoneH + safezoneY;
    w = 0.489844 * safezoneW;
    h = 0.484 * safezoneH;
  };
  class civInteractGreetings: RscButton
  {
  	idc = 9100;
  	action = "['greetings'] call civ_fnc_InteractQuestionsPop;";

  	text = "Greetings."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.302 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };
  class civInteractQuestions: RscButton
  {
  	idc = 9200;
  	action = "['questions'] call civ_fnc_InteractQuestionsPop;";

  	text = "Basic Questions."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.368 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class civInteractHostile: RscButton
  {
  	idc = 9300;
    action = "['hostile'] call civ_fnc_InteractQuestionsPop;";
  	text = "Enemy Questions."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.434 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class civInteractCivilan: RscButton
  {
  	idc = 9400;
    action = "['civilian'] call civ_fnc_InteractQuestionsPop;";
  	text = "Civilian Questions."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.5 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };
  class civInteract5: RscButton
  {
  	idc = 9500;

  	text = "TBD."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.566 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };
  class civInteractActions: RscButton
  {
  	idc = 9600;
    action = "['actions'] call civ_fnc_InteractQuestionsPop;";
  	text = "Actions."; //--- ToDo: Localize;
  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.632 * safezoneH + safezoneY;
  	w = 0.165 * safezoneW;
  	h = 0.0464444 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  //
  //Greetings Actions
  //

  class GreetingAction1: RscButton
  {
    idc = 9101;
    action = "";

    text = "Action 1."; //--- ToDo: Localize;
    x = 0.489687 * safezoneW + safezoneX;
    y = 0.269 * safezoneH + safezoneY;
    w = 0.0825 * safezoneW;
    h = 0.044 * safezoneH;
    colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction2: RscButton
  {
    idc = 9102;
    action = "";

    text = "Action 2."; //--- ToDo: Localize;
    x = 0.587656 * safezoneW + safezoneX;
    y = 0.269 * safezoneH + safezoneY;
    w = 0.0825 * safezoneW;
    h = 0.044 * safezoneH;
    colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction3: RscButton
  {
    idc = 9103;
  	action = "";

  	text = "Action 3."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.335 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction4: RscButton
  {
    idc = 9104;
  	action = "";

  	text = "Action 4."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.335 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction5: RscButton
  {
    idc = 9105;
  	action = "";

  	text = "Action 5."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.401 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction6: RscButton
  {
    idc = 9106;
  	action = "";

  	text = "Action 6."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.401 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction7: RscButton
  {
    idc = 9107;
  	action = "";

  	text = "Action 7."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.467 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction8: RscButton
  {
    idc = 9108;
  	action = "";

  	text = "Action 8."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.467 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction9: RscButton
  {
    idc = 9109;
  	action = "";

  	text = "Action 9."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.533 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction10: RscButton
  {
    idc = 9110;
  	action = "";

  	text = "Action 10."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.533 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction11: RscButton
  {
    idc = 9111;
  	action = "";

  	text = "Action 11."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.599 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction12: RscButton
  {
    idc = 9112;
  	action = "";

  	text = "Action 12."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.599 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };

  class GreetingAction13: RscButton
  {
    idc = 9113;
  	action = "";

  	text = "Action 13."; //--- ToDo: Localize;
  	x = 0.489687 * safezoneW + safezoneX;
  	y = 0.665 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };
  class GreetingAction14: RscButton
  {
    idc = 9114;
  	action = "";

  	text = "Action 14."; //--- ToDo: Localize;
  	x = 0.587656 * safezoneW + safezoneX;
  	y = 0.665 * safezoneH + safezoneY;
  	w = 0.0825 * safezoneW;
  	h = 0.044 * safezoneH;
  	colorActive[] = {0.922,0.643,0.204,1};
  };
};








































class intelMain
{
	idd = -1;
  onLoad = "[] remoteExec ['vics_diag_intelUpdate',0];"; //code to run when it loads
  onUnload = ""; //code to run when its closed

	class ControlsBackground
	{
		class bgrnd
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.22555556;
			w = safeZoneW * 0.411875;
			h = safeZoneH * 0.54888889;
			style = 0;
			text = "";
			colorBackground[] = {0.302,0.302,0.302,0.5294};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};

	};
	class Controls
	{
		class Points
		{
			type = 0;
			idc = 2101;
			x = safeZoneX + safeZoneW * 0.50625;
			y = safeZoneY + safeZoneH * 0.26777778;
			w = safeZoneW * 0.163125;
			h = safeZoneH * 0.2;
			style = 0+2;
			text = "Points";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.8,0.8,0.8,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};

	};

};


class missionDisplayMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    missionListBox,
    btnMissionDetails,
    btnMissionActivate,
    btnMissionDelete
  }; //anything that doesn't fit into the category below
  controlsBackground[] = {
    IGUIBack_2200
  }; //background things that can’t be interacted with

  ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Towybi)
////////////////////////////////////////////////////////

  class missionListBox: RscListBox
  {
  	idc = 2601;

  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.236 * safezoneH + safezoneY;
  	w = 0.190781 * safezoneW;
  	h = 0.528 * safezoneH;
  };
  class btnMissionDetails: RscButton
  {
  	idc = 2602;
  	text = "Mission Details"; //--- ToDo: Localize;
  	x = 0.551562 * safezoneW + safezoneX;
  	y = 0.247 * safezoneH + safezoneY;
  	w = 0.108281 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class btnMissionDelete: RscButton
  {
  	idc = 2603;
  	text = "Delete Mission"; //--- ToDo: Localize;
  	x = 0.551562 * safezoneW + safezoneX;
  	y = 0.676 * safezoneH + safezoneY;
  	w = 0.108281 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class btnMissionActivate: RscButton
  {
  	idc = 2604;
  	text = "Activate Mission"; //--- ToDo: Localize;
  	x = 0.551562 * safezoneW + safezoneX;
  	y = 0.324 * safezoneH + safezoneY;
  	w = 0.108281 * safezoneW;
  	h = 0.055 * safezoneH;
  };
  class IGUIBack_2200: IGUIBack
  {
  	idc = 2599;
  	x = 0.29375 * safezoneW + safezoneX;
  	y = 0.225 * safezoneH + safezoneY;
  	w = 0.4125 * safezoneW;
  	h = 0.55 * safezoneH;
  };
  ////////////////////////////////////////////////////////
  // GUI EDITOR OUTPUT END
  ////////////////////////////////////////////////////////
};


class missionDisplayDetails
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = false; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = "[] call vem_diag_setMissionDetails;uiNamespace setVariable ['missionDisplayDetails', _this select 0]"; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
stxtMissionDetails
  }; //anything that doesn't fit into the category below
  controlsBackground[] = {
    IGUIBack_test
  }; //background things that can’t be interacted with

  class IGUIBack_test: IGUIBack
  {
  	idc = 2200;

  	x = 0.29375 * safezoneW + safezoneX;
  	y = 0.22632 * safezoneH + safezoneY;
  	w = 0.4125 * safezoneW;
  	h = 0.55 * safezoneH;
  };
  class stxtMissionDetails: RscStructuredText
  {
  	idc = 1100;

  	x = 0.298906 * safezoneW + safezoneX;
  	y = 0.236 * safezoneH + safezoneY;
  	w = 0.402187 * safezoneW;
  	h = 0.418 * safezoneH;
  };

};


class vicsTabletHome
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    intelApp,
    RscPicture_1202,
    RscPicture_1203,
    RscPicture_1204,
    app1Button,
    app2Button,
    app3Button,
    app4Button,
    homeButton
  };
  controlsBackground[] = {
    tabletBackground
  }; //backgroun

  class tabletBackground: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tablet.paa";
  	x = 0;
  	y = 0;
  	w = 1;
  	h = 1;
  };
  class intelApp: RscPicture
  {
  	idc = 1201;

  	text = "tablet\intelApp.paa";
  	x = 0.1375;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class app1Button: RscButton
  {
  	idc = 1201;
  	action = "closeDialog 0; [] call vics_ply_playerExit;";
    text = "Player Exit";
  	x = 0.1375;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class RscPicture_1202: RscPicture
  {
  	idc = 1202;
  	text = "tablet\expApp.paa";
  	x = 0.325;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class app2Button: RscButton
  {
  	idc = 1202;
  	action = "closeDialog 0; createDialog 'LevelUpDialogMain'";

  	x = 0.325;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class RscPicture_1203: RscPicture
  {
  	idc = 1203;

  	text = "tablet\intelApp.paa";
  	x = 0.5375;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class app3Button: RscButton
  {
  	idc = 1203;

  	x = 0.5375;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class RscPicture_1204: RscPicture
  {
  	idc = 1204;

  	text = "tablet\intelApp.paa";
  	x = 0.725;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class app4Button: RscButton
  {
  	idc = 1204;

  	x = 0.725;
  	y = 0.16;
  	w = 0.1375;
  	h = 0.18;
  };
  class homeButton: RscButton
  {
  	idc = 1604;
  	x = 0.9125;
  	y = 0.46;
  	w = 0.05;
  	h = 0.08;
    color[] = {0,0,0,0};
    colorActive[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    periodFocus = 0;
    action = "closeDialog 0; createDialog 'vicsTabletHome';";
  };

};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Gyjojy)
////////////////////////////////////////////////////////

class vicsTabletLogin
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    homeButton,
    loginName,
    passwordText,
    loginButton
  };
  controlsBackground[] = {
    tabletBackground
  }; //backgroun


  class tabletBackground: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tablet.paa";
  	x = 0;
  	y = 0;
  	w = 1;
  	h = 1;
  };
  class homeButton: RscButton
  {
  	idc = 1604;
  	x = 0.9125;
  	y = 0.46;
  	w = 0.05;
  	h = 0.08;
    color[] = {0,0,0,0};
    colorActive[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    periodFocus = 0;
    period = 0;
    periodOver = 0;
  };
  class loginName: RscEdit
  {
  	idc = 1000;
  	text = "User"; //--- ToDo: Localize;
  	x = 0.3875;
  	y = 0.3;
  	w = 0.25;
  	h = 0.04;
  };
  class passwordText: RscEdit
  {
  	idc = 1001;
  	text = "Password"; //--- ToDo: Localize;
  	x = 0.3875;
  	y = 0.36;
  	w = 0.25;
  	h = 0.04;
  };
  class loginButton: RscButton
  {
  	idc = 1600;
  	text = "Login"; //--- ToDo: Localize;
  	x = 0.375;
  	y = 0.46;
  	w = 0.2125;
  	h = 0.1;
    action = "_user = ctrlText 1000;  _pass = ctrlText 1001; [_user,_pass] call vics_tablet_login;";




  };
};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Polyna)
////////////////////////////////////////////////////////
class vicsIntelDescription
{
  idd = 888; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    homeButton,
    intelTextBox
  };
  controlsBackground[] = {
    tabletBackground
  }; //backgroun
  class tabletBackground: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tablet.paa";
  	x = 0;
  	y = 0;
  	w = 1;
  	h = 1;
  };
  class homeButton: RscButton
  {
  	idc = 1604;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
    action = "closeDialog 0; createDialog 'vicsTabletHome';";

  	x = 0.9125;
  	y = 0.46;
  	w = 0.05;
  	h = 0.08;
  	colorActive[] = {0,0,0,0};
  };
  class intelTextBox: RscStructuredText
  {
  	idc = 1101;
    x = 0.1;
  	y = 0.18;
  	w = 0.7625;
  	h = 0.66;
	colorText[] = {1,1,1,1};
	class Attributes
  	{
  		font = "RobotoCondensed";
  		color = "#ffffff";
  		colorLink = "#D09B43";
  		align = "center";
  		shadow = 1;
  	};
    text = "";
  };
};

class vicsXpDisplay
{
  idd = 900; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  //onLoad = "[] call lvlup_fnc_displayXP;"; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    homeButton,
    intelTextBox
  };
  controlsBackground[] = {
    tabletBackground
  }; //backgroun
  class tabletBackground: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tablet.paa";
  	x = 0;
  	y = 0;
  	w = 1;
  	h = 1;
  };
  class homeButton: RscButton
  {
  	idc = 1604;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
    action = "closeDialog 0; createDialog 'vicsTabletHome';";

  	x = 0.9125;
  	y = 0.46;
  	w = 0.05;
  	h = 0.08;
  	colorActive[] = {0,0,0,0};
  };
  class intelTextBox: RscStructuredText
  {
  	idc = 1101;
    x = 0.1;
  	y = 0.18;
  	w = 0.7625;
  	h = 0.66;
	colorText[] = {1,1,1,1};
	class Attributes
  	{
  		font = "RobotoCondensed";
  		color = "#ffffff";
  		colorLink = "#D09B43";
  		align = "center";
  		shadow = 1;
  	};
    text = "";
  };
};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by D. Repo, v1.063, #Jageki)
////////////////////////////////////////////////////////

class vicsTabletIntelMain
{
  idd = -1; //no need for the whole dialog to be referenced at any time.
  movingEnable = true; //not moving
  moving = 1; // who the hell knows what this does????????
  onLoad = ""; //code to run when it loads
  onUnload = ""; //code to run when its closed
  controls[] = {
    homeButton,
    intelList,
    intelText,
    button1,
    button2,
    button3,
    button4
  };
  controlsBackground[] = {
    tabletBackground
  }; //backgroun


  class homeButton: RscButton
  {
  	idc = 1604;
  	color[] = {0,0,0,0};
  	colorBackgroundActive[] = {0,0,0,0};
  	colorFocused[] = {0,0,0,0};
  	periodFocus = 0;
  	period = 0;
  	periodOver = 0;
    action = "closeDialog 0; createDialog 'vicsTabletHome';";
  	x = 0.9125;
  	y = 0.46;
  	w = 0.05;
  	h = 0.08;
  	colorActive[] = {0,0,0,0};
  };
  class intelList: RscListbox
  {
  	idc = 1500;
  	x = 0.1125;
  	y = 0.16;
  	w = 0.35;
  	h = 0.58;
  };
  class intelText: RscStructuredText
  {
  	idc = 1100;
  	x = 0.4875;
  	y = 0.2;
  	w = 0.3375;
  	h = 0.38;
  };
  class button1: RscButton
  {
  	idc = 1601;
  	x = 0.4875;
  	y = 0.72;
  	w = 0.1;
  	h = 0.08;
  };
  class button2: RscButton
  {
  	idc = 1602;
  	x = 0.725;
  	y = 0.72;
  	w = 0.1;
  	h = 0.08;
  };
  class button3: RscButton
  {
  	idc = 1603;
  	x = 0.4875;
  	y = 0.6;
  	w = 0.1;
  	h = 0.08;
  };
  class button4: RscButton
  {
  	idc = 1604;
  	x = 0.725;
  	y = 0.6;
  	w = 0.1;
  	h = 0.08;
  };
  class tabletBackground: RscPicture
  {
  	idc = 1200;

  	text = "tablet\tablet.paa";
  	x = 0;
  	y = 0;
  	w = 1;
  	h = 1;
  };
};

class RCAS
{
	idd = -1;
	movingEnable = true;
	onLoad = "[] spawn rcas_ui_start";

	class ControlsBackground
	{
		class phone
		{
			moving = 1;
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.39375;
			y = safeZoneY + safeZoneH * 0.12666667;
			w = safeZoneW * 0.2375;
			h = safeZoneH * 0.69666667;
			style = 48;
			text = "phone.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class mapBoarder
		{
			type = 0;
			idc = 1540;
			x = safeZoneX + safeZoneW * 0.44;
			y = safeZoneY + safeZoneH * 0.51111112;
			w = safeZoneW * 0.14375;
			h = safeZoneH * 0.24555556;
			style = 80;
			text = "";
			colorBackground[] = {0.6,0.6,0.6,1};
			colorText[] = {0.2235,0.5216,0.8196,0};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;

		};

	};
	class Controls
	{
		class gridInput
		{
			type = 2;
			idc = 1550;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Target Grid";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Grid Reference for Target.";

		};
		class order
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.44375;
			y = safeZoneY + safeZoneH * 0.37111112;
			w = safeZoneW * 0.1375;
			h = safeZoneH * 0.03666667;
			style = 2;
			text = "Send Request";
			action = "_tgt = ctrlText 1550; _ingr = ctrlText 1551; _dir = ctrlText 1552; _dist = ctrlText 1553; _munition = ctrlText 1554; _cCode = ctrlText 1555;[_tgt,_ingr,_dir,_dist,_munition,_cCode] spawn rcas_fnc_radio;";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {0.4,0.6,0.4,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};

		};
		class IngressInput
		{
			type = 2;
			idc = 1551;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.27333334;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Ingress Grid";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Grid reference for ingress to target.";

		};
		class DirectionInput
		{
			type = 2;
			idc = 1552;
			x = safeZoneX + safeZoneW * 0.41875;
			y = safeZoneY + safeZoneH * 0.32222223;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "DIrection";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Direction from ingress to target.";

		};
		class Map: RCAS_MAP
		{
			idc = 1541;
			x = safeZoneX + safeZoneW * 0.44375;
			y = safeZoneY + safeZoneH * 0.51777778;
			w = safeZoneW * 0.1375;
			h = safeZoneH * 0.23222223;
			text = "";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 2;

		};
		class DistanceInput
		{
			type = 2;
			idc = 1553;
			x = safeZoneX + safeZoneW * 0.516875;
			y = safeZoneY + safeZoneH * 0.22555556;
			w = safeZoneW * 0.088125;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Distance";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Distance from ingress to target.";

		};
		class showTracker
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.494375;
			y = safeZoneY + safeZoneH * 0.43555556;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Tracker";
			action = "[] spawn rcas_ui_tracker";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {0.949,0.949,0.949,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Show/Hide Tracker.";

		};
		class MunitionsInput
		{
			type = 2;
			idc = 1554;
			x = safeZoneX + safeZoneW * 0.516875;
			y = safeZoneY + safeZoneH * 0.27444445;
			w = safeZoneW * 0.088125;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Munitions";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Type of munitions to engage with.";

		};
		class CancelCodeInput
		{
			type = 2;
			idc = 1555;
			x = safeZoneX + safeZoneW * 0.516875;
			y = safeZoneY + safeZoneH * 0.32333334;
			w = safeZoneW * 0.088125;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Cancel Code";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Custom code for cancelling strike.";

		};
		class showMap
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.444375;
			y = safeZoneY + safeZoneH * 0.43555556;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Map";
			action = "[] spawn rcas_ui_map";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {0.949,0.949,0.949,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Show/Hide Map";

		};
		class tracker
		{
			type = 0;
			idc = 1561;
			x = safeZoneX + safeZoneW * 0.45375;
			y = safeZoneY + safeZoneH * 0.54222223;
			w = safeZoneW * 0.1175;
			h = safeZoneH * 0.03666667;
			style = 2+192;
			text = "";
			colorBackground[] = {0.702,0.702,0.702,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 2;

		};
		class CommsShow
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.544375;
			y = safeZoneY + safeZoneH * 0.43555556;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Comms";
			action = "[] spawn rcas_ui_comms";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {0.949,0.949,0.949,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			tooltip = "Show/Hide Communications.";

		};
		class Confirm
		{
			type = 1;
			idc = 1571;
			x = safeZoneX + safeZoneW * 0.46875;
			y = safeZoneY + safeZoneH * 0.52222223;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Confirm";
			borderSize = 0;
			colorBackground[] = {0.0078,0.2745,0.0275,1};
			colorBackgroundActive[] = {0.302,0.502,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};

		};
		class Deny
		{
			type = 1;
			idc = 1572;
			x = safeZoneX + safeZoneW * 0.46875;
			y = safeZoneY + safeZoneH * 0.57111112;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Deny";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {0.8,0.2,0.2,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};

		};
		class Cancel
		{
			type = 1;
			idc = 1573;
			x = safeZoneX + safeZoneW * 0.46875;
			y = safeZoneY + safeZoneH * 0.68777778;
			w = safeZoneW * 0.0875;
			h = safeZoneH * 0.03666667;
			style = 0+2;
			text = "Cancel";
			borderSize = 0;
			colorBackground[] = {0.6,0,0,1};
			colorBackgroundActive[] = {0.8,0.2,0.2,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};

		};
		class cancelCode
		{
			type = 2;
			idc = 1574;
			x = safeZoneX + safeZoneW * 0.470625;
			y = safeZoneY + safeZoneH * 0.64111112;
			w = safeZoneW * 0.084375;
			h = safeZoneH * 0.03666667;
			style = 0;
			text = "Cancel Code";
			autocomplete = "";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {0,0.2,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			access = 0;
			tooltip = "Custom code for cancelling strike.";

		};

	};






};
