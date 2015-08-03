// LSL script generated - patched Render.hs (0.1.6.2): LSLScripts.nPose DayNight Plugin.lslp Mon Aug  3 17:14:48 Mitteleuropäische Sommerzeit 2015
// This example shows you how to register and use an user defined permission
// If you put this script into your nPose build, you will be able to use
// the permission {day}, which is true during the SL day and false during the SL night.
// example:
// SET:Poses:reading{day}
// SET:Poses:sleeping{!day}
// this will enable the button "reading" during the SL day and the button "sleeping" during the SL night
//
// Have fun
// Leona (slmember1 Resident)


string MY_PERMISSION_NAME = "day";

integer getDay(){
    vector sun = llGetSunDirection();
    if (sun.z > -0.1) {
        return 1;
    }
    return 0;
}

updatePermissionBool(string permissionName,integer flag){
    string str = llList2CSV([permissionName,"bool",flag]);
    llMessageLinked(-1,-806,str,NULL_KEY);
}

default {

	state_entry() {
        llSetMemoryLimit(llGetUsedMemory() + 2048);
        updatePermissionBool(MY_PERMISSION_NAME,getDay());
        llSetTimerEvent(300.0);
    }

	timer() {
        updatePermissionBool(MY_PERMISSION_NAME,getDay());
    }
}
