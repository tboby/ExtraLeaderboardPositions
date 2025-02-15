// ################
// ### Settings ###
// ################

[Setting category="Display Settings" name="Window visible" description="To move the windows, click and drag while the Openplanet overlay is visible."]
bool windowVisible = true;

[Setting category="Display Settings" name="Display mode" description="When should the overlay be displayed?"]
EnumDisplayMode displayMode = EnumDisplayMode::ALWAYS;

[Setting hidden]
float hiddingSpeedSetting = 1.0f;

[Setting hidden name="Refresh timer (minutes)" description="The amount of time between automatic refreshes of the leaderboard. Must be over 0." min=1]
int refreshTimer = 5;

[Setting hidden]
bool showPb = true;


[Setting hidden]
bool showMedals = true;

[Setting hidden]
bool showAT = true;
[Setting hidden]
bool showGold = true;
[Setting hidden]
bool showSilver = true;
[Setting hidden]
bool showBronze = true;

[Setting hidden]
EnumDisplayMedal medalDisplayMode = EnumDisplayMedal::NORMAL;


[Setting hidden]
bool showRefreshButtonSetting = true;

[Setting hidden]
int nbSizePositionToGetArray = 1;

[Setting hidden]
string allPositionToGetStringSave = "";

// unsaved counterpart allPositionToGet is in the main file;

[Setting hidden]
bool showTimeDifference = true;

[Setting hidden]
bool showColoredTimeDifference = true;

[Setting hidden]
bool inverseTimeDiffSign = false;

[Setting hidden]
int currentComboChoice = -1;