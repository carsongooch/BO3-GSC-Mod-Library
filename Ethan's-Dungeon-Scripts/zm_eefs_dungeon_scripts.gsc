#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;


#using scripts\shared\ai\zombie_utility;

#precache( "fx", "dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg" );
#precache( "fx", "explosions/fx_exp_plane_crash_child_prologue");


function autoexec elevator_repair()
{
	//start all rituals
	thread ritual_2();
	gear_place = GetEnt("gear_place", "targetname");
	gear_place Hide();
	gear_p1 = GetEnt("gear_p1", "targetname");
	gear_p2 = GetEnt("gear_p2", "targetname");
	gear_p3 = GetEnt("gear_p3", "targetname");
	elevator_door_clip = GetEnt("elevator_door_clip", "targetname");
	gear_p1 Hide();
	gear_p2 Hide();
	gear_p3 Hide();
	elevator_door_clip Hide();
	level.gear_count = 0;
	thread elevator_message_f();
	radio = GetEnt("radio", "targetname");
	radio_trig = GetEnt("radio_trig", "targetname");
	radio_trig SetHintString("Hold ^3[{+activate}]^7 to Pick up Radio");
	radio_trig waittill("trigger", player);
	radio Delete();
	radio_trig Delete();
	//Wait time for dialoge of Nathan
	wait 0;
	thread gear1_f();
	thread gear2_f();
	thread gear3_f();
}

function autoexec glass_shootable1() {
	level.glass_count = 0;
	glass_shoot1 = GetEnt("glass_shoot1", "targetname");
	glass_target1 = GetEnt("glass_target1", "targetname");
	glass_target1 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot1 GetOrigin());
	glass_shoot1 Delete();
	glass_target1 Delete();
	thread glass_shot();
}

function autoexec glass_shootable2() {
	glass_shoot2 = GetEnt("glass_shoot2", "targetname");
	glass_target2 = GetEnt("glass_target2", "targetname");
	glass_target2 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot2 GetOrigin());
	glass_shoot2 Delete();
	glass_target2 Delete();
	thread glass_shot();
}

function autoexec glass_shootable3() {
	glass_shoot3 = GetEnt("glass_shoot3", "targetname");
	glass_target3 = GetEnt("glass_target3", "targetname");
	glass_target3 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot3 GetOrigin());
	glass_shoot3 Delete();
	glass_target3 Delete();
	thread glass_shot();
}

function autoexec glass_shootable4() {
	glass_shoot4 = GetEnt("glass_shoot4", "targetname");
	glass_target4 = GetEnt("glass_target4", "targetname");
	glass_target4 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot4 GetOrigin());
	glass_shoot4 Delete();
	glass_target4 Delete();
	thread glass_shot();
}

function autoexec glass_shootable5() {
	glass_shoot5 = GetEnt("glass_shoot5", "targetname");
	glass_target5 = GetEnt("glass_target5", "targetname");
	glass_target5 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot5 GetOrigin());
	glass_shoot5 Delete();
	glass_target5 Delete();
	thread glass_shot();
}

function autoexec glass_shootable6() {
	glass_shoot6 = GetEnt("glass_shoot6", "targetname");
	glass_target6 = GetEnt("glass_target6", "targetname");
	glass_target6 waittill("damage");
	PlayFX("dlc3/stalingrad/fx_dragon_gauntlet_transport_flash_lg", glass_shoot6 GetOrigin());
	glass_shoot6 Delete();
	glass_target6 Delete();
	thread glass_shot();
}

function glass_complete() {
	//this function is work in progress just placeholding
	if (level.glass_count == 1000) {
		level.glass_count = 0; //placeholder
	}
}

function glass_shot() {
	players = getPlayers();
	for (i = 0;i<players.size;i++)
	{
		players[i] PlayLocalSound("glassshoot_sfx");
	}
	level.glass_count++;
	thread give_points();
	IPrintLnBold(level.glass_count + "/20 Glass Bottles Found");
}

function give_points() {
	players = GetPlayers();

	foreach(player in players) {
		player zm_score::add_to_player_score(1000);
		player PlayLocalSound("glassshoot_sfx");
	}
}

function autoexec bottle_quest() {
	level.bottle_count = 0;
	thread bottle_one();
	thread bottle_two();
	thread bottle_three();
}

function bottle_one() {
	bottle1 = getEnt("bottle1", "targetname");
	bottle1 waittill("trigger", player);
	bottle1 playSound("xp_sound");
	level.bottle_count++;
	thread bottle_reward();
}

function bottle_two() {
	bottle2 = getEnt("bottle2", "targetname");
	bottle2 waittill("trigger", player);
	level.bottle_count++;
	bottle2 playSound("xp_sound");
	thread bottle_reward();
}

function bottle_three() {
	bottle3 = getEnt("bottle3", "targetname");
	bottle3 waittill("trigger", player);
	bottle3 playSound("xp_sound");
	level.bottle_count++;
	thread bottle_reward();
}

function bottle_reward() {
	if (level.bottle_count == 3) {
		players = GetPlayers();
		random_num = RandomInt(101);
			
		if (random_num >= 98) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_perkaholic");
			}
		} else if (random_num >= 95) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_power_vacuum");
			}
		} else if (random_num >= 90) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_near_death_experience");
			}
		} else if (random_num >= 85) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_soda_fountain");
			}
		} else if (random_num >= 80) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_self_medication");
			}
		} else if (random_num >= 70) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_extra_credit");
			}
		} else if (random_num >= 60) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_immolation_liquidation");
			}
		} else if (random_num >= 50) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_crate_power");
			}
		} else if (random_num >= 40) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_extra_credit");
			}
		} else if (random_num >= 30) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_on_the_house");
			}
		} else if (random_num >= 20) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_fear_in_headlights");
			}
		} else if (random_num >= 10) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_secret_shopper");
			}	
		} else if (random_num >= 5) {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_phoenix_up");
			}	
		} else {
			for (i = 0; i < players.size; i++) {
				players[i] bgb::give("zm_bgb_licensed_contractor");
			}	
		}
	}
}

function autoexec ee_song() {
	level.bear_count = 0;
	thread bear_one();
	thread bear_two();
	thread bear_three();
}

function bear_one() {
	bear1 = GetEnt("bear1", "targetname");
	bear_target1 = GetEnt("bear_target1", "targetname");
	bear_target1 waittill("damage");
	level.bear_count++;
	PlayFX("explosions/fx_exp_plane_crash_child_prologue", bear1 GetOrigin());
	bear1 playSound("xp_sound");
	bear1 Delete();
	bear_target1 Delete();
	thread bear_complete();
}

function bear_two() {
	bear2 = GetEnt("bear2", "targetname");
	bear_target2 = GetEnt("bear_target2", "targetname");
	bear_target2 waittill("damage");
	level.bear_count++;
	PlayFX("explosions/fx_exp_plane_crash_child_prologue", bear2 GetOrigin());
	bear2 playSound("xp_sound");
	bear2 Delete();
	bear_target2 Delete();
	thread bear_complete();
}

function bear_three() {
	bear3 = GetEnt("bear3", "targetname");
	bear_target3 = GetEnt("bear_target3", "targetname");
	bear_target3 waittill("damage");
	level.bear_count++;
	PlayFX("explosions/fx_exp_plane_crash_child_prologue", bear3 GetOrigin());
	bear3 playSound("xp_sound");
	bear3 Delete();
	bear_target3 Delete();
	thread bear_complete();
}

function bear_complete() {
	if (level.bear_count == 3) {
		//play song
	}
}

function autoexec setup_image_var() {
    // Start at 1 so the script doesn't default to the 'else' statement (song3)
    level.song_image = 1; 
}

function autoexec jukebox_main() {
    jukebox_on_trig = GetEnt("jukebox_on_trig", "targetname");
    jukebox_change_song_trig = GetEnt("jukebox_change_song_trig", "targetname");
    stop_jukebox_trig = GetEnt("stop_jukebox_trig", "targetname");

    // Initial Setup
    jukebox_on_trig SetHintString("Hold ^3[{+activate}]^7 to turn on Jukebox");
    jukebox_change_song_trig SetHintString("Hold ^3[{+activate}]^7 to Change Song ^1(Shoot Jukebox to Stop Music)");
    
    jukebox_change_song_trig Hide();
    thread jukebox_image_hide();

    while(1) {
        jukebox_on_trig waittill("trigger", player);
        
        jukebox_on_trig Hide();
        jukebox_change_song_trig Show();
        jukebox_on_trig PlaySound("xp_sound");

        // Show the current image without advancing the counter
        thread show_jukebox_image_nocounter();

        // Start the thread that listens for song changes
        thread jukebox_change_songs_loop();

        // 2. Wait for player to shoot (turn OFF) the jukebox
        stop_jukebox_trig waittill("damage");

        // Forcefully kill the change_songs_loop thread so it stops waiting for a trigger press
        level notify("jukebox_turned_off"); 

        // Reset the triggers hide images and stop
        jukebox_change_song_trig Hide();
        jukebox_on_trig Show();
        thread jukebox_image_hide();
		thread stop_music();
        
        wait 0.1; 
    }
}

function jukebox_change_songs_loop() {
    level endon("jukebox_turned_off"); 
    
    jukebox_change_song_trig = GetEnt("jukebox_change_song_trig", "targetname");

    while(1) {
        jukebox_change_song_trig waittill("trigger", player);
        show_jukebox_image();
        wait 0.1;
    }
}

function show_jukebox_image_nocounter() {
    if (level.song_image >= 4) {
        level.song_image = 1;
    }
    update_jukebox_models();
}

function show_jukebox_image() {
    level.song_image++;
	thread stop_music();
    if (level.song_image >= 4) {
        level.song_image = 1;
    }
    update_jukebox_models();
}

function update_jukebox_models() {
	//wait so the stop_music() function can run and stop all music
	wait 0.1;
	players = getPlayers();
    song1 = GetEnt("song1", "targetname");
    song2 = GetEnt("song2", "targetname");
    song3 = GetEnt("song3", "targetname");

    // Hide everything first to ensure old images disappear
    song1 Hide();
    song2 Hide();
    song3 Hide();

    // Show only the active image
    if (level.song_image == 1) {
        song1 Show();
		for (i = 0;i<players.size;i++)
		{
			players[i] PlayLocalSound("electro_zoo");
		}
    } else if (level.song_image == 2) {
        song2 Show();
		for (i = 0;i<players.size;i++)
		{
			players[i] PlayLocalSound("sweet_victory");
		}
    } else if (level.song_image == 3) {
        song3 Show();
		for (i = 0;i<players.size;i++)
		{
			players[i] PlayLocalSound("buried_alive");
		}
    }
}

function jukebox_image_hide() {
    song1 = GetEnt("song1", "targetname");
    song2 = GetEnt("song2", "targetname");
    song3 = GetEnt("song3", "targetname");

    // The 'isdefined' check prevents map-start crash errors if radiant hasn't loaded the models yet
    if(isdefined(song1)) song1 Hide();
    if(isdefined(song2)) song2 Hide();
    if(isdefined(song3)) song3 Hide();
}

function stop_music() {
	players = getPlayers();
	for (i = 0;i<players.size;i++) {
		players[i] StopLocalSound("electro_zoo");
		players[i] StopLocalSound("buried_alive");
		players[i] StopLocalSound("sweet_victory");
	}
}

function gear1_f()
{
	gear1 = GetEnt("gear1","targetname");
	gear1_trig = GetEnt("gear1_trig", "targetname");
	gear1_trig SetHintString("Hold ^3[{+activate}]^7 to Pick up Gear");
	gear1_trig waittill("trigger", player);
	gear1 PlaySound("gear_pickup");
	gear1 Delete();
	gear1_trig Delete();
	level.gear_count++;
	thread gear_place_f();
}
function gear2_f()
{
	gear2 = GetEnt("gear2","targetname");
	gear2_trig = GetEnt("gear2_trig", "targetname");
	gear2_trig SetHintString("Hold ^3[{+activate}]^7 to Pick up Gear");
	gear2_trig waittill("trigger", player);
	gear2 PlaySound("gear_pickup");
	gear2 Delete();
	gear2_trig Delete();
	level.gear_count++;
	thread gear_place_f();
}
function gear3_f()
{
	gear3 = GetEnt("gear3","targetname");
	gear3_trig = GetEnt("gear3_trig", "targetname");
	gear3_trig SetHintString("Hold ^3[{+activate}]^7 to Pick up Gear");
	gear3_trig waittill("trigger", player);
	gear3 PlaySound("gear_pickup");
	gear3 Delete();
	gear3_trig Delete();
	level.gear_count++;
	thread gear_place_f();
}
function elevator_message_f()
{
	elevator_message = GetEnt("elevator_message", "targetname");
	elevator_message SetHintString("The Elevator Must be Repaired...");
	elevator_message waittill("trigger", player);
}

function gear_place_f()
{
	if (level.gear_count == 3)
	{
		elevator_message = GetEnt("elevator_message", "targetname");
		elevator_message Delete();
		gear_p1 = GetEnt("gear_p1", "targetname");
		gear_p2 = GetEnt("gear_p2", "targetname");
		gear_p3 = GetEnt("gear_p3", "targetname");

		gear_place = GetEnt("gear_place", "targetname");
		gear_place Show();
		gear_place SetHintString("Hold ^3[{+activate}]^7 to Place Gear");
		gear_place waittill("trigger", player);
		gear_p1 Show();
		gear_place waittill("trigger", player);
		gear_p2 Show();
		gear_place waittill("trigger", player);
		gear_p3 Show();
		gear_place Delete();
		elevator_start = GetEnt("elevator_start", "targetname");
		elevator_start SetHintString("Hold ^3[{+activate}]^7 to Start Elevator");
		elevator_start waittill("trigger", player);
		elevator_start Delete();
		elevator_door_clip = GetEnt("elevator_door_clip", "targetname");
		elevator_door_clip Show();
		level thread RotatingEntities1();
		level thread RotatingEntities2();
		level thread RotatingEntities3();
		wait 1;
		level thread elevator_door_close_right();
		level thread elevator_door_close_left();
		wait 6;
		thread elevator_go();
	}


}


function RotatingEntities1()
{
	/*==================== ROTATING ENTITIES BY PROGRAM115 ====================
		Using either a script_model or script_brushmodel, give it the KvP of targetname: rotate_ent

		Add any of the following kvps:
		script_noteworthy: Rotation axis (x, y or z). Default = 'x'
		script_transition_time: Time taken for 1 rotation
		script_string: Is power required for it to rotate? (yes = 'power', no = leave blank)
		script_sound: Sound to play from the entity while it's rotating. MUST BE A LOOPING AND 3D SOUND
	*/
	gear_p1 = GetEntArray("gear_p1", "targetname");
	if(isdefined(gear_p1))
	{
		for(i = 0; i < gear_p1.size; i++)
		{
			gear_p1[i] thread rotate_ent1();
		}
	}
}
function rotate_ent1()
{
	//Handles speed
	if(isdefined(self.script_transition_time))
	{
		speed = self.script_transition_time;
	}
	else
	{
		speed = 5;
	}

	//Handle power requirement
	if(isdefined(self.script_string))
	{
		//The user wants power to be required
		level waittill("power_on");
	}

	//Handle sound playing while rotating
	if(isdefined(self.script_sound))
	{
		self PlayLoopSound(self.script_sound);
	}

	//Rotate the entities
	while(1)
	{
		if(isdefined(self.script_noteworthy))
		{
			if(self.script_noteworthy == "x")
			{
				self rotateRoll(360, speed);
			}
			else if(self.script_noteworthy == "y")
			{
				self rotatePitch(360, speed);
			}
			else if(self.script_noteworthy == "z")
			{
				self rotateYaw(360, speed);
			}
		}
		else
		{
			self rotateRoll(360, speed);
		}
		wait(speed);
	}
}






function RotatingEntities2()
{
	gear_p2 = GetEntArray("gear_p2", "targetname");
	if(isdefined(gear_p2))
	{
		for(i = 0; i < gear_p2.size; i++)
		{
			gear_p2[i] thread rotate_ent2();
		}
	}
}
function rotate_ent2()
{
	//Handles speed
	if(isdefined(self.script_transition_time))
	{
		speed = self.script_transition_time;
	}
	else
	{
		speed = 5;
	}

	//Handle power requirement
	if(isdefined(self.script_string))
	{
		//The user wants power to be required
		level waittill("power_on");
	}

	//Handle sound playing while rotating
	if(isdefined(self.script_sound))
	{
		self PlayLoopSound(self.script_sound);
	}

	//Rotate the entities
	while(1)
	{
		if(isdefined(self.script_noteworthy))
		{
			if(self.script_noteworthy == "x")
			{
				self rotateRoll(-360, speed);
			}
			else if(self.script_noteworthy == "y")
			{
				self rotatePitch(360, speed);
			}
			else if(self.script_noteworthy == "z")
			{
				self rotateYaw(360, speed);
			}
		}
		else
		{
			self rotateRoll(360, speed);
		}
		wait(speed);
	}
}


function generate_code() {
	print_code = array(0);
	thread test();

	random_number = RandomIntRange(0,9);
	random_number1 = RandomIntRange(0,9);
	random_number2 = RandomIntRange(0,9);
	random_number3 = RandomIntRange(0,9);
	code = array(random_number,random_number1,random_number2,random_number3);
		foreach ( print_code in code) {
			IPrintLnBold(print_code);
			wait 1;
		}
	}


function RotatingEntities3()
{
	gear_p3 = GetEntArray("gear_p3", "targetname");
	if(isdefined(gear_p3))
	{
		for(i = 0; i < gear_p3.size; i++)
		{
			gear_p3[i] thread rotate_ent3();
		}
	}
}
function rotate_ent3()
{
	//Handles speed
	if(isdefined(self.script_transition_time))
	{
		speed = self.script_transition_time;
	}
	else
	{
		speed = 5;
	}

	//Handle power requirement
	if(isdefined(self.script_string))
	{
		//The user wants power to be required
		level waittill("power_on");
	}

	//Handle sound playing while rotating
	if(isdefined(self.script_sound))
	{
		self PlayLoopSound(self.script_sound);
	}

	//Rotate the entities
	while(1)
	{
		if(isdefined(self.script_noteworthy))
		{
			if(self.script_noteworthy == "x")
			{
				self rotateRoll(360, speed);
			}
			else if(self.script_noteworthy == "y")
			{
				self rotatePitch(360, speed);
			}
			else if(self.script_noteworthy == "z")
			{
				self rotateYaw(360, speed);
			}
		}
		else
		{
			self rotateRoll(360, speed);
		}
		wait(speed);
	}
}

function elevator_door_close_right(){

	elevator_door1_right = GetEnt("elevator_door1_right", "targetname");
	elevator_door1_right PlaySound("elevator_door_close");
	elevator_door1_right MoveY(22,4);


}


function elevator_door_close_left(){

	elevator_door1_left = GetEnt("elevator_door1_left", "targetname");
	elevator_door1_left MoveY(-22,4);

}


function elevator_go(){
	thread eef_meet();
	gear_p1 = GetEnt("gear_p1", "targetname");
	gear_p2 = GetEnt("gear_p2", "targetname");
	gear_p3 = GetEnt("gear_p3", "targetname");
	elevator_block = GetEnt("elevator_block", "targetname");
	elevator_door1_right = GetEnt("elevator_door1_right", "targetname");
	elevator_door1_left = GetEnt("elevator_door1_left", "targetname");
	elevator_door1_right PlaySound("elevator_going_down");
	elevator_floor = GetEnt("elevator_floor", "targetname");
	elevator_panel = GetEnt("elevator_panel", "targetname");
	elevator = GetEnt("elevator", "targetname");
	elevator MoveZ(-900, 42);
	elevator_floor MoveZ(-900, 42);
	elevator_panel MoveZ(-900, 42);
	gear_p1 MoveZ(-900, 42);
	gear_p2 MoveZ(-900, 42);
	gear_p3 MoveZ(-900, 42);
	elevator_block MoveZ(-500, 42);
	elevator_door1_right MoveZ(-900, 42);
	elevator_door1_left MoveZ(-900, 42);
	wait 44;
	elevator_door1_left MoveY(22,4);
	elevator_door1_right MoveY(-22,4);
}			

function eef_meet() {
	thread generate_code();
	level flag::clear("spawn_zombies");
	eef_talk = GetEnt("eef_talk", "targetname");
	eef_talk SetHintString("Hold ^3[{+activate}]^7 to talk to Ethan");
	eef_talk waittill("trigger", player);
	eef_talk Delete();
	level flag::set("spawn_zombies"); 
}

function test () {
	audio_t = GetEnt("audio_t", "targetname");
	audio_t SetHintString("sdfdsfsdfdsf");
	audio_t waittill("trigger", player);
	audio_t playSound("steve");
}

function ritual_2() {
	ritual2_clip = GetEnt("ritual2_clip", "targetname");
	ritual2_door = GetEnt("ritual2_door", "targetname");
	ritual2_trigger = GetEnt("ritual2_trigger", "targetname");
	ritual2_trigger SetHintString("Hold ^3[{+activate}]^7 to begin stroking my pp");
	ritual2_trigger waittill("trigger", player);
	ritual2_trigger Delete();
	ritual2_clip Delete();
	ritual2_door MoveY(-22, 4);
}
