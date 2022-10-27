/// @desc

// Inherit the parent event
event_inherited();

enum States{
	sleeping,
	waking,
	rolling
}

wakingCurrent = 0;
wakingTime = 1000000;

set_hp(5);

damage_sprite = {
	spr_enemy_bear: spr_enemy_bear_roll,
}

xdir = 1;
spd = 0.6;
grav = 0.19;
vsp = 0;
vsp_max = 5.5;

cooldown = 0;
state = States.sleeping;

grounded = false;

function sleep()
{
	var checkx  = checkForPlayer();
	if(checkx != 0)
	{
		xdir = checkx;
	}
}

function wake(deltaTime)
{
	wakingCurrent+= deltaTime;
	if(wakingCurrent > wakingTime)
	{
		//instance_destroy();
		instance_destroy();
	}
}

function roll(deltaTime)
{
	
}


/*
 Checks if the player is in range on either side
 Returns:
	-1 if player detected left
	1 if player detected right
	0 if no detection
*/
function checkForPlayer()
{
	//check left
		if(collision_line(x-16, y+24, x-176, y+24,obj_player,false,true)){
			state = States.waking;
			return -1;
		}
		//check right
		else if(collision_line(x, y+24, x+160, y+24,obj_player,false,true)){
			state = States.waking;
			return 1;
		}
		else{
			return 0;
		}
}

function groundCheck()
{
	grounded = place_meeting(x, y+2, obj_wall);
}

function fall(deltaTime)
{
	if(!grounded)
	{
		vsp = approach(vsp, vsp_max, grav*deltaTime );
		y+= vsp;
		
	}
}