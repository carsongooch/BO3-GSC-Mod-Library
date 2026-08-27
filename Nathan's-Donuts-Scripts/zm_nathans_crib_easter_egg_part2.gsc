#using scripts\shared\flag_shared;
#using scripts\zm\_zm_perks;
#using scripts\shared\array_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\shared\util_shared;
#using scripts\codescripts\struct;
#using scripts\shared\laststand_shared;
#using scripts\zm\_zm_weapons;
#using scripts\shared\ai\zombie_utility;
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_rex_ai_skullbreaker;
#using scripts\zm\_zm;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_utility;


#precache( "fx", "zombie/fx_powerup_on_green_zmb" );
#precache( "fx", "zombie/fx_ritual_pap_energy_trail" );
#precache( "fx", "zombie/fx_powerup_off_green_zmb" );
#precache( "fx", "dlc1/castle/fx_rune_glow_purple" );
#namespace grow_soul;

function init()
{
	thread step9();
}




//EASTER EGG PART 2


function step9 {

	IPrintLnBold("All Soul Boxes Filled!");
	electric_door_message = GetEnt("electric_door_message", "targetname");
	electric_door_message Delete();
	basement_door_clip = GetEnt("basement_door_clip", "targetname");
	basement_door_clip Delete();

	basement_electric_door = GetEnt("basement_electric_door", "targetname");
	basement_electric_door Delete();

	activate_final_tele = GetEnt("activate_final_tele", "targetname");
	activate_final_tele SetHintString("Hold ^3[{+activate}]^7 to Activate Teleporter");
	activate_final_tele waittill("trigger", player);
	activate_final_tele Delete();
	final_tele_message = GetEnt("final_tele_message", "targetname");
	final_tele_message SetHintString("Talk to Nathan...");
	thread step10();
	final_tele_message waittill("trigger", player);
}


function step10()
{
	n_talk6 = GetEnt("n_talk6", "targetname");
	n_talk6 SetHintString("Hold ^3[{+activate}]^7 to Talk to Nathan");
	n_talk6 waittill("trigger", player);
	n_talk6 Delete();
	players = GetPlayers();
	for (i = 0;i<players.size;i++)
	{
		players[i] PlayLocalSound("nathan_q6");
	}
	wait 26;
	IPrintLnBold("Objective:Start The Bossfight.");
	final_tele_message = GetEnt("final_tele_message", "targetname");
	final_tele_message Delete();
	bossfight_tele = GetEnt("bossfight_tele", "targetname");
	bossfight_tele SetHintString("Hold ^3[{+activate}]^7 to Start the Bossfight ^1(All Players Must be Near!)");
	bossfight_tele waittill("trigger", player);
	const maxRadius = 125; // radius from trigger all players need to be within

		while(isdefined(bossfight_tele))
		{
		        b_canUse = true;

		        foreach(player in getplayers())
		        {
		            
		            // Check if the player is in spectator mode
		            if(player.sessionstate == "spectator")
		            {
		            	b_canUse = false;
		            	break;
		            }
		            
		            // Check distance between player and trigger
		            distsqrd = DistanceSquared(player.origin, bossfight_tele.origin);
		            if(distsqrd >= maxRadius * maxRadius)
		            {
		                // If any player is outside the activation radius, trigger cannot be used
		                b_canUse = false;
		                // Break out of the loop since trigger cannot be used
		                break;
		            }
		        }

		        // If all players are not down and within the activation radius, trigger can be used
		        if(b_canUse)
		        {
		            // Delete the trigger since it has been successfully used
		            bossfight_tele Delete();
		            // Exit the loop since trigger has been used
		            break;
		        }

		        // Wait for a short duration before rechecking trigger activation conditions
		        wait 0.5;
		    }
	thread bossfight_teleport();
	thread KillAllZombies();
	wait 0.5;
	thread bossfight();
}

function bossfight_teleport()
{
	thread bossfight_teleport_p2();
	thread bossfight_teleport_p3();
	thread bossfight_teleport_p4();
	bossfight_tele_rad = GetEnt("bossfight_tele_rad", "targetname");
	bossfight_tele_rad Show();
	player_tp = GetEntArray( "bossfight_tele_rad", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport1();
	}
}


function bossfight_teleport_p2()
{
	wait 0.10;
	bossfight_tele_rad1 = GetEnt("bossfight_tele_rad1", "targetname");
	bossfight_tele_rad1 Show();
	player_tp = GetEntArray( "bossfight_tele_rad1", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport2();
	}

}

function bossfight_teleport_p3()
{
	wait 0.20;
	bossfight_tele_rad2 = GetEnt("bossfight_tele_rad2", "targetname");
	bossfight_tele_rad2 Show();
	player_tp = GetEntArray( "bossfight_tele_rad2", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport3();
	}

}


function bossfight_teleport_p4()
{
	wait 0.30;
	bossfight_tele_rad3 = GetEnt("bossfight_tele_rad3", "targetname");
	bossfight_tele_rad3 Show();
	player_tp = GetEntArray( "bossfight_tele_rad3", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport4();
	}

}

function bossfight_teleport1()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}

function bossfight_teleport2()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}

function bossfight_teleport3()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}

function bossfight_teleport4()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}

function bossfight()
{
	//disable all zones
	thread KillAllZombies(25, 1000000);
	level.zones["start_zone"].is_enabled = false;
	level.zones["zone_2"].is_enabled = false;
	level.zones["zone_3"].is_enabled = false;
	level.zones["zone_4"].is_enabled = false;
	level.zones["zone_5"].is_enabled = false;
	level.zones["zone_6"].is_enabled = false;
	level.zones["zone_7"].is_enabled = false;
	level.zones["street_zone1"].is_enabled = false;
	level.zones["street_zone2"].is_enabled = false;
	level.zones["street_zone3"].is_enabled = false;
	level.zones["street_zone4"].is_enabled = false;
	level.zones["street_zone5"].is_enabled = false;
	level.zones["street_zone6"].is_enabled = false;
	level.zones["street_zone7"].is_enabled = false;
	level.zones["street_zone8"].is_enabled = false;
	level.zones["vape_zone1"].is_enabled = false;
	level.zones["vape_zone2"].is_enabled = false;
	level.zones["house_zone1"].is_enabled = false;
	level.zones["house_zone2"].is_enabled = false;
	level.zones["house_zone3"].is_enabled = false;
	level.zones["forest_zone1"].is_enabled = false;
	level.zones["forest_zone2"].is_enabled = false;
	level.zones["bunker_zone"].is_enabled = false;
	level.zones["final_zone1"].is_enabled = false;
	level.zones["final_zone2"].is_enabled = false;
	level.zones["final_zone3"].is_enabled = false;
	level.zones["zone_2b"].is_enabled = false;
	level.zones["zone_2c"].is_enabled = false;
	level flag::clear("spawn_zombies");
	level.zones["bossfight2_zone"].is_enabled = false;
	level.zones["bossfight3_zone"].is_enabled = false;
	level.zones["bossfight4_zone"].is_enabled = false;
	bossfight_activate1 = GetEnt("bossfight_activate1", "targetname");
	bossfight_activate1 SetHintString("Hold ^3[{+activate}]^7 to Start Stage One ^1(All Players Must be Near!)");
	bossfight_activate1 waittill("trigger", player);
	const maxRadius = 125; // radius from trigger all players need to be within

		while(isdefined(bossfight_activate1))
		{
		        b_canUse = true;

		        foreach(player in getplayers())
		        {
		            
		            // Check if the player is in spectator mode
		            if(player.sessionstate == "spectator")
		            {
		            	b_canUse = false;
		            	break;
		            }
		            
		            // Check distance between player and trigger
		            distsqrd = DistanceSquared(player.origin, bossfight_activate1.origin);
		            if(distsqrd >= maxRadius * maxRadius)
		            {
		                // If any player is outside the activation radius, trigger cannot be used
		                b_canUse = false;
		                // Break out of the loop since trigger cannot be used
		                break;
		            }
		        }

		        // If all players are not down and within the activation radius, trigger can be used
		        if(b_canUse)
		        {
		            // Delete the trigger since it has been successfully used
		            bossfight_activate1 Delete();
		            // Exit the loop since trigger has been used
		            break;
		        }

		        // Wait for a short duration before rechecking trigger activation conditions
		        wait 0.5;
		    }
	level flag::set("spawn_zombies"); 
	thread infinite_zombies();
	wait 120;
	thread KillAllZombies(25, 10000000);
	maxammo_spawn3 = GetEnt("maxammo_spawn3", "targetname");
	drop_point = maxammo_spawn3 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);
	bossfight1_field = GetEnt("bossfight1_field", "targetname");
	bossfight1_field Hide();
	bossfight_clip1 = GetEnt("bossfight_clip1", "targetname");
	bossfight_clip1 Hide();
	level flag::clear("spawn_zombies");


	bossfight_activate2 = GetEnt("bossfight_activate2", "targetname");
	bossfight_activate2 SetHintString("Hold ^3[{+activate}]^7 to Start Stage Two ^1(All Players Must be Near!)");
	bossfight_activate2 waittill("trigger", player);

		while(isdefined(bossfight_activate2))
		{
		        b_canUse = true;

		        foreach(player in getplayers())
		        {
		            
		            // Check if the player is in spectator mode
		            if(player.sessionstate == "spectator")
		            {
		            	b_canUse = false;
		            	break;
		            }
		            
		            // Check distance between player and trigger
		            distsqrd = DistanceSquared(player.origin, bossfight_activate2.origin);
		            if(distsqrd >= maxRadius * maxRadius)
		            {
		                // If any player is outside the activation radius, trigger cannot be used
		                b_canUse = false;
		                // Break out of the loop since trigger cannot be used
		                break;
		            }
		        }

		        // If all players are not down and within the activation radius, trigger can be used
		        if(b_canUse)
		        {
		            // Delete the trigger since it has been successfully used
		            bossfight_activate2 Delete();
		            // Exit the loop since trigger has been used
		            break;
		        }

		        // Wait for a short duration before rechecking trigger activation conditions
		        wait 0.5;
		    }
	//trial 2
	level.zones["bossfight2_zone"].is_enabled = true;
	bossfight1_zone = GetEnt("bossfight1_zone", "targetname");
	level.zones["bossfight1_zone"].is_enabled = false;
	bossfight1_field Show();
	bossfight_clip1 Show();
	level flag::set("spawn_zombies"); 
	thread infinite_zombies();
	wait 15;
	    // Get a random spawner from the mechz spawners array
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial2_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 40;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial2_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 30;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial2_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 30;
	thread KillAllZombies(25, 10000000);
	bossfight2_field = GetEnt("bossfight2_field", "targetname");
	bossfight2_field Hide();
	bossfight_clip2 = GetEnt("bossfight_clip2", "targetname");
	bossfight_clip2 Hide();
	level flag::clear("spawn_zombies");
	maxammo_spawn2 = GetEnt("maxammo_spawn2", "targetname");
	drop_point = maxammo_spawn2 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);
	level.zones["bossfight3_zone"].is_enabled = true;
	bossfight2_spawners = GetEntArray("bossfight2_spawners", "targetname");

	bossfight_activate3 = GetEnt("bossfight_activate3", "targetname");
	bossfight_activate3 SetHintString("Hold ^3[{+activate}]^7 to Start Stage Three ^1(All Players Must be Near!)");
	bossfight_activate3 waittill("trigger", player);

		while(isdefined(bossfight_activate3))
		{
		        b_canUse = true;

		        foreach(player in getplayers())
		        {
		            
		            // Check if the player is in spectator mode
		            if(player.sessionstate == "spectator")
		            {
		            	b_canUse = false;
		            	break;
		            }
		            
		            // Check distance between player and trigger
		            distsqrd = DistanceSquared(player.origin, bossfight_activate3.origin);
		            if(distsqrd >= maxRadius * maxRadius)
		            {
		                // If any player is outside the activation radius, trigger cannot be used
		                b_canUse = false;
		                // Break out of the loop since trigger cannot be used
		                break;
		            }
		        }

		        // If all players are not down and within the activation radius, trigger can be used
		        if(b_canUse)
		        {
		            // Delete the trigger since it has been successfully used
		            bossfight_activate3 Delete();
		            // Exit the loop since trigger has been used
		            break;
		        }

		        // Wait for a short duration before rechecking trigger activation conditions
		        wait 0.5;
		    }
	//trial 3 
	bossfight2_zone = GetEnt("bossfight2_zone", "targetname");
	bossfight2_field Show();
	bossfight_clip2 Show();
	level.zones["bossfight2_zone"].is_enabled = false;
	level flag::set("spawn_zombies"); 
	thread infinite_zombies();
	wait 20;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 30;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    e_spawner = array::random(level.mechz_spawners);
    wait 1;

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 1;
    e_spawner = array::random(level.mechz_spawners);

    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 40;
    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 1;
    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial3_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    wait 40;

	thread KillAllZombies(25, 10000000);
	bossfight3_field = GetEnt("bossfight3_field", "targetname");
	bossfight3_field Hide();
	bossfight_clip3 = GetEnt("bossfight_clip3", "targetname");
	bossfight_clip3 Hide();
	level flag::clear("spawn_zombies");
	maxammo_spawn1 = GetEnt("maxammo_spawn1", "targetname");
	drop_point = maxammo_spawn1 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);

	bossfight_activate4 = GetEnt("bossfight_activate4", "targetname");
	bossfight_activate4 SetHintString("Hold ^3[{+activate}]^7 to Start Stage Four ^1(All Players Must be Near!)");
	bossfight_activate4 waittill("trigger", player);
	while(isdefined(bossfight_activate4))
		{
		        b_canUse = true;

		        foreach(player in getplayers())
		        {
		            
		            // Check if the player is in spectator mode
		            if(player.sessionstate == "spectator")
		            {
		            	b_canUse = false;
		            	break;
		            }
		            
		            // Check distance between player and trigger
		            distsqrd = DistanceSquared(player.origin, bossfight_activate4.origin);
		            if(distsqrd >= maxRadius * maxRadius)
		            {
		                // If any player is outside the activation radius, trigger cannot be used
		                b_canUse = false;
		                // Break out of the loop since trigger cannot be used
		                break;
		            }
		        }

		        // If all players are not down and within the activation radius, trigger can be used
		        if(b_canUse)
		        {
		            // Delete the trigger since it has been successfully used
		            bossfight_activate4 Delete();
		            // Exit the loop since trigger has been used
		            break;
		        }

		        // Wait for a short duration before rechecking trigger activation conditions
		        wait 0.5;
		    }
	bossfight_activate4 Delete();

	//trial 4
	skull_test = GetEnt("skull_test", "targetname");
	bossfight_clip3 Show();
	bossfight3_field Show();
	level.zones["bossfight4_zone"].is_enabled = true;
	bossfight3_zone = GetEnt("bossfight3_zone", "targetname");
	level.zones["bossfight3_zone"].is_enabled = false;
	level flag::set("spawn_zombies"); 
	thread infinite_zombies();
	galaxy_donut = GetEnt("galaxy_donut", "targetname");
	donutfx = GetEnt("donutfx", "targetname");
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 15;
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
    // Define the spawn location (can be random or specific)
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 12500;
    e_ai.health = e_ai.maxhealth;
	wait 20;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 30;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);

    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
   	wait 20;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 40;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    wait 15;
	maxammo_spawn4 = GetEnt("maxammo_spawn4", "targetname");
	drop_point = maxammo_spawn4 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);
	wait 15;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
	wait 1;
	rex_skullbreaker_ai::spawn_skullbreaker(skull_test, false );
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    mechz_finale_locations = struct::get_array("trial4_p_spawns", "targetname");
    s_location = array::random(mechz_finale_locations);
    wait 1;
    // Spawn the Panzer using zombie_utility::spawn_zombie
    e_ai = zombie_utility::spawn_zombie(e_spawner, e_spawner.targetname, s_location);
    e_ai.maxhealth = 10000;
    e_ai.health = e_ai.maxhealth;
    wait 30;
	maxammo_spawn4 = GetEnt("maxammo_spawn4", "targetname");
	drop_point = maxammo_spawn4 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);
	wait 30;
	maxammo_spawn4 = GetEnt("maxammo_spawn4", "targetname");
	drop_point = maxammo_spawn4 GetOrigin();
	zm_powerups::specific_powerup_drop("full_ammo", drop_point);
	thread KillAllZombies(25, 10000000);
	level flag::clear("spawn_zombies");
	side_donut = GetEnt("side_donut", "targetname");
	galaxy_donut Show();
	side_donut Delete();
	PlayFX("dlc1/castle/fx_rune_glow_purple", donutfx GetOrigin());

	grab_galaxy_donut = GetEnt("grab_galaxy_donut", "targetname");
	grab_galaxy_donut SetHintString("Hold ^3[{+activate}]^7 to Grab the ^6Galaxy Donut");
	grab_galaxy_donut waittill("trigger", player);

	galaxy_donut Delete();
	grab_galaxy_donut Delete();
	IPrintLnBold("Galaxy Donut Collected...");
	level.zones["start_zone"].is_enabled = true;
	level.zones["zone_2"].is_enabled = true;
	level.zones["zone_3"].is_enabled = true;
	level.zones["zone_4"].is_enabled = true;
	level.zones["zone_5"].is_enabled = true;
	level.zones["zone_6"].is_enabled = true;
	level.zones["zone_7"].is_enabled = true;
	level.zones["street_zone1"].is_enabled = true;
	level.zones["street_zone2"].is_enabled = true;
	level.zones["street_zone3"].is_enabled = true;
	level.zones["street_zone4"].is_enabled = true;
	level.zones["street_zone5"].is_enabled = true;
	level.zones["street_zone6"].is_enabled = true;
	level.zones["street_zone7"].is_enabled = true;
	level.zones["street_zone8"].is_enabled = true;
	level.zones["vape_zone1"].is_enabled = true;
	level.zones["vape_zone2"].is_enabled = true;
	level.zones["house_zone1"].is_enabled = true;
	level.zones["house_zone2"].is_enabled = true;
	level.zones["house_zone3"].is_enabled = true;
	level.zones["forest_zone1"].is_enabled = true;
	level.zones["forest_zone2"].is_enabled = true;
	level.zones["bunker_zone"].is_enabled = true;
	level.zones["final_zone1"].is_enabled = true;
	level.zones["final_zone2"].is_enabled = true;
	level.zones["final_zone3"].is_enabled = true;
	level.zones["zone_2b"].is_enabled = true;
	level.zones["zone_2c"].is_enabled = true;
	level flag::clear("spawn_zombies");
	level.zones["bossfight2_zone"].is_enabled = true;
	level.zones["bossfight3_zone"].is_enabled = true;
	level.zones["bossfight4_zone"].is_enabled = true;
	wait 5;
	IPrintLnBold("Teleporting Back...");
	wait 3;
	IPrintLnBold("5");
	wait 1;
	IPrintLnBold("4");
	wait 1;
	IPrintLnBold("3");
	wait 1;
	IPrintLnBold("2");
	wait 1;
	IPrintLnBold("1");
	wait 1;	
	thread bossfight_teleport_out_p1();
	thread bossfight_teleport_out_p2();
	thread bossfight_teleport_out_p3();
	thread bossfight_teleport_out_p4();
	wait 0.5;
	thread step11();
}


function infinite_zombies()
{
	level.zombie_total = 1000000;
}

function KillAllZombies( max_zombies, range )
{
	zombies = getaispeciesarray( level.zombie_team );

	zombies = util::get_array_of_closest( self.origin, zombies, undefined, max_zombies, range );

	for (i = 0; i < zombies.size; i++)
	{
		wait (randomfloatrange(0.2, 0.3));
		if( !IsDefined( zombies[i] ) )
		{
			continue;
		}


		zombies[i] dodamage( 10000000, zombies[i].origin );
		playsoundatposition( "nuked", zombies[i].origin );
	}
}



function bossfight_teleport_out_p1()
{
	bossfight_trig_tele1 = GetEnt("bossfight_trig_tele1", "targetname");
	bossfight_trig_tele1 Show();
	player_tp = GetEntArray( "bossfight_trig_tele1", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport_out1();
	}

}

function bossfight_teleport_out1()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}



function bossfight_teleport_out_p2()
{
	wait 0.10;
	bossfight_trig_tele2 = GetEnt("bossfight_trig_tele2", "targetname");
	bossfight_trig_tele2 Show();
	player_tp = GetEntArray( "bossfight_trig_tele2", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport_out2();
	}

}

function bossfight_teleport_out2()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}


function bossfight_teleport_out_p3()
{
	wait 0.20;
	bossfight_trig_tele3 = GetEnt("bossfight_trig_tele3", "targetname");
	bossfight_trig_tele3 Show();
	player_tp = GetEntArray( "bossfight_trig_tele3", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport_out3();
	}

}

function bossfight_teleport_out3()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}


function bossfight_teleport_out_p4()
{
	wait 0.30;
	bossfight_trig_tele4 = GetEnt("bossfight_trig_tele4", "targetname");
	bossfight_trig_tele4 Show();
	player_tp = GetEntArray( "bossfight_trig_tele4", "targetname");
	for( i = 0; i < player_tp.size; i++ )
	{
		player_tp[i] thread bossfight_teleport_out4();
	}

}

function bossfight_teleport_out4()
{
	destination = GetEnt( self.target, "targetname" );
	self waittill( "trigger", player );
	player SetOrigin( destination.origin );
	player SetPlayerAngles( destination.angles );
}


function step11()
{
	n_talk7 = GetEnt("n_talk7", "targetname");
	n_talk7 SetHintString ("Hold ^3[{+activate}]^7 to Talk to Nathan");
	n_talk7 waittill("trigger", player);
	n_talk7 Delete();

	players = GetPlayers();
	for (i = 0;i<players.size;i++)
	{
		players[i] PlayLocalSound("nathan_q7");
	}
	thread endless_quote();
	wait 9;
	IPrintLnBold("Objective:Escape!");
	escape_heli = GetEnt("escape_heli", "targetname");
	escape_heli Show();
	ending = GetEnt("ending", "targetname");
	ending Show();

}

function endless_quote()
{
	wait 9;
	while(1)
	{
	n_talk8 = GetEnt("n_talk8", "targetname");
	n_talk8 SetHintString ("Hold ^3[{+activate}]^7 to Talk to Nathan");
	n_talk8 waittill("trigger", player);
	players = GetPlayers();
	for (i = 0;i<players.size;i++)
		{
			players[i] PlayLocalSound("nathan_q8");
		}
	}
}
