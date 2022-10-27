/// @desc

// Inherit the parent event
event_inherited();

enum States{
	sleeping,
	waking,
	rolling
}

set_hp(5);

damage_sprite = {
	spr_enemy_bear: spr_enemy_bear_roll,
}

dir = -1;
spd = 0.3;

cooldown = 0;
state = States.sleeping;

function sleep()
{
	var checkx  = checkForPlayer();
	if(checkx != 0)
	{
		xdir = checkx;
	}
}

function wake()
{
	
}

function roll()
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
	
		if(collision_line(x-16, y+24, x-160, y+24,obj_player,false,true)){instance_destroy()}
}