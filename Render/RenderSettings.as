[SettingsTab name="General Customization"]
void RenderSettingsCustomization(){

    if(!UserCanUseThePlugin()){
        UI::Text("You don't have the required permissions to use this plugin. You at least need the standard edition.");
        return;
    }

    if(UI::Button("Reset to default")){
        showRefreshButtonSetting = true;
        hiddingSpeedSetting = 1.0f;
        refreshTimer = 5;
        showPb = true;
        showTimeDifference = true;
        showColoredTimeDifference = true;
        inverseTimeDiffSign = false;
        currentComboChoice = -1;
    }

    showRefreshButtonSetting = UI::Checkbox("Add refresh button to UI (only appears when OP Overlay is on)", showRefreshButtonSetting);

    UI::Text("\n\tDisplay mode customizations");

    hiddingSpeedSetting = UI::InputFloat("Hide if speed is above X (if the hide when driving mode is active)", hiddingSpeedSetting);
    if(hiddingSpeedSetting < 0){
        hiddingSpeedSetting = 0;
    }

    UI::Text("\n\tTimer");

    refreshTimer = UI::InputInt("Refresh timer every X (minutes)", refreshTimer);

    UI::Text("\n\tPersonal best");

    showPb = UI::Checkbox("Show personal best", showPb);


    UI::Text("\n\tTime difference");
    showTimeDifference = UI::Checkbox("Show time difference", showTimeDifference);
    if(showTimeDifference){
        inverseTimeDiffSign = UI::Checkbox("Inverse sign (+ instead of -)", inverseTimeDiffSign);

        showColoredTimeDifference = UI::Checkbox("Color the time difference (blue if negative, red otherwise)", showColoredTimeDifference);

        UI::Text("\t\tFrom which position should the time difference be shown?");
        string comboText = "";
        if(currentComboChoice == -1){
            comboText = "Personal best";
        }else{
            comboText = "Position " + currentComboChoice;
        }

        if(UI::BeginCombo("Time Diff position", comboText)){
            if(UI::Selectable("Personal best", currentComboChoice == -1)){
                currentComboChoice = -1;
                UI::SetItemDefaultFocus();
            }
            for(int i = 0; i < int(allPositionToGet.Length); i++){
                string text = "Position " + allPositionToGet[i];
                if(UI::Selectable(text, currentComboChoice == allPositionToGet[i])){
                    currentComboChoice = allPositionToGet[i];
                }
            }
            UI::EndCombo();
        }
            

    }
    
}

[SettingsTab name="Explanation"]
void RenderSettingsExplanation(){
    UI::Text("This plugin allows you to see more leaderboard positions.\n\n");
    UI::Text("You can modify the positions in the \"Positions customization\" tab\n");
    UI::Text("\nThe leaderboard is refreshed every " + refreshTimer + " minutes when in a map.");
    UI::Text("This timer resets when you leave the map and is automatically refreshed when you join a map, or if you set a new pb on a map.");;
    UI::Text("\nThe plugin also allows you to see the time difference between a given position and all the other one.");
    UI::Text("\nThe medals can also be added to the leaderboard. You can see them as \"if you had a time of X, you would be at the Y position\".\nBecause of API limitation, the medals are not shown in the leaderboard if you have them.");
    UI::Dummy(vec2(0,150));
    UI::Text("Made by Banalian.\nContact me on Discord (you can find me on the OpenPlanet Discord) if you have any questions or suggestions !\nYou can also use the github page to post about any issue you might encounter or any feature you would like added to this plugin.");
}

[SettingsTab name="Medals Position"]
void RenderMedalSettings(){
    if(!UserCanUseThePlugin()){
        UI::Text("You don't have the required permissions to use this plugin. You at least need the standard edition.");
        return;
    }

    UI::Text("The UI will be updated when the usual conditions are met (see Explanation) or if you press the refresh button.");

    if(UI::Button("Reset to default")){
        showMedals = true;
        showAT = true;
        showGold = true;
        showSilver = true;
        showBronze = true;
        medalDisplayMode = EnumDisplayMedal::NORMAL;
    }

    if(UI::Button("Refresh")){
        if(!refreshPosition){
            refreshPosition = true;
        }
    }

    showMedals = UI::Checkbox("Show medals estimated positions", showMedals);

    if(showMedals){
        showAT = UI::Checkbox("Show AT", showAT);
        showGold = UI::Checkbox("Show Gold", showGold);
        showSilver = UI::Checkbox("Show Silver", showSilver);
        showBronze = UI::Checkbox("Show Bronze", showBronze);
    }

    UI::Text("\n\tAppearance");

    // Show it as normal, greyed out and/or italic
    string comboTitle = "Invalid state";

    switch(medalDisplayMode){
        case EnumDisplayMedal::NORMAL:
            comboTitle = "Normal";
            break;
        case EnumDisplayMedal::IN_GREY:
            comboTitle = "In grey";
            break;
    }

    if(UI::BeginCombo("Medal display mode", comboTitle)){
        if(UI::Selectable("Normal", medalDisplayMode == EnumDisplayMedal::NORMAL)){
            medalDisplayMode = EnumDisplayMedal::NORMAL;
        }
        if(UI::Selectable("In grey", medalDisplayMode == EnumDisplayMedal::IN_GREY)){
            medalDisplayMode = EnumDisplayMedal::IN_GREY;
        }

        UI::EndCombo();
    }

}

[SettingsTab name="Positions customization"]
void RenderPositionCustomization(){

    if(!UserCanUseThePlugin()){
        UI::Text("You don't have the required permissions to use this plugin. You at least need the standard edition.");
        return;
    }

    UI::Text("The UI will be updated when the usual conditions are met (see Explanation) or if you press the refresh button.");

    if(UI::Button("Reset to default")){
        allPositionToGet = {1,10,100,1000,10000};
        allPositionToGetStringSave = "1,10,100,1000,10000";
        nbSizePositionToGetArray = 5;
    }

    if(UI::Button("Refresh")){
        if(!refreshPosition){
            refreshPosition = true;
        }
    }

    for(int i = 0; i < nbSizePositionToGetArray; i++){
        int tmp = UI::InputInt("Custom position " + (i+1), allPositionToGet[i]);
        if(tmp != allPositionToGet[i]){
            if(currentComboChoice == allPositionToGet[i]){
                currentComboChoice = tmp;
            }
            allPositionToGet[i] = tmp;
            OnSettingsChanged();
        }
    }


    if(UI::Button("+ : Add a position")){
        nbSizePositionToGetArray++;
        allPositionToGet.InsertLast(1);
        OnSettingsChanged();
    }
    if(UI::Button("- : Remove a position")){
        if(nbSizePositionToGetArray > 1){
            nbSizePositionToGetArray--;
            allPositionToGet.RemoveAt(nbSizePositionToGetArray);
            OnSettingsChanged();
        }
    }
}