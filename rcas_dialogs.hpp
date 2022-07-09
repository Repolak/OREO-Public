
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
