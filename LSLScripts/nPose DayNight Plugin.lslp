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
//
// Source Code:
// https://github.com/LeonaMorro/nPose-DayNight-plugin
//
// Report Bugs to:
// https://github.com/LeonaMorro/nPose-DayNight-plugin/issues
// or IM slmember1 Resident (Leona)


string MY_PERMISSION_NAME="day";
integer UDPBOOL=-804;

integer getDay() {
	//returns TRUE during the SL day and FALSE during the SL night
	vector sun=llGetSunDirection();
	if(sun.z>-0.1) {
		return TRUE;
	}
	return FALSE;
}

updatePermissionBool(string permissionName, integer flag) {
	// the string consists of:
	// the unique permission name you want to use
	// the current Value: 1 or 0
	llMessageLinked(LINK_SET, UDPBOOL, permissionName + "=" + (string)flag, NULL_KEY);
}

default {
	state_entry() {
		//we do't need so much script memory for this script
		llSetMemoryLimit(llGetUsedMemory() + 2048);
		//send one update at the beginnig, so you have not to wait 5 minutes until the first update occurs
		updatePermissionBool(MY_PERMISSION_NAME, getDay());
		//set the timer to check for day/night every 5 minutes (300s)
		llSetTimerEvent(300.0);
	}
	timer() {
		updatePermissionBool(MY_PERMISSION_NAME, getDay());
	}
}
