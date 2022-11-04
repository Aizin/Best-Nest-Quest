/// @desc

// Inherit the parent event
event_inherited();

enum States{
	sleeping,
	waking,
	rolling,
	stunned,
}

player = obj_player;

wakingCurrent = 0;
wakingTime = 1000000;

stunCurrent = 0;
stunTime = 1000000;

current_bounces = bounce_amount;

set_hp(maxHp);

damage_sprite = {
	spr_enemy_bear: spr_enemy_bear_roll,
}

rolling_sprite = {
	spr_enemy_bear: spr_enemy_bear_roll,
}

awake_sprite = {
	spr_enemy_bear: spr_enemy_bear_alert,
}

stunned_sprite = {
	spr_enemy_bear: spr_enemy_bear_alert,
}

xdir = x_direction;
spd = 0.6;
grav = 0.19;
vsp = 0;
spd = 1.6;
hsp = 0;

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
		state = States.waking;
	}
}

function wake(deltaTime)
{
	wakingCurrent+= deltaTime;
	lookAt(player);
	if(wakingCurrent > wakingTime)
	{
		
		state = States.rolling;
		wakingCurrent = 0;
	}
}

function stunned(deltaTime)
{
	stunCurrent+= deltaTime;
	if(stunCurrent > stunTime)
	{
		
		state = States.sleeping;
		stunCurrent = 0;
	}
}

function roll(deltaTime)
{
	//check if wall in path
	if(collision_line(x+16*xdir, y-20, x+10*xdir, y-20,obj_wall,false,true)){
			//state = States.sleeping;
			bounce();
		}
	else
	{
		x += xdir*spd*deltaTime/10000;	
	}
	
}


function flip()
{
	xdir*=-1;
}

// If bounce_amount < 0, infinitely bounce
function bounce()
{
	if(current_bounces < 0)
	{
		flip()
	}
	else
	{
		if(current_bounces > 0)
		{
			current_bounces--;	
			flip();
		}
		else if(current_bounces == 0)
		{
			state = States.stunned;
			current_bounces = bounce_amount;
			
		}
		
	}
	
}

function lookAt(obj)
{
	if(obj!=pointer_null)
	{
		if(x < obj.x)
		{
		xdir = 1;	
		}
		else{
		xdir = -1;	
		}
	}
	
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
		if(collision_line(x-16, y-12, x-176, y-12,obj_player,false,true)){
			return -1;
		}
		//check right
		else if(collision_line(x, y-12, x+160, y-12,obj_player,false,true)){
			
			return 1;
		}
		else{
			return 0;
		}
}

function groundCheck()
{
	grounded = place_meeting(x, y+1, obj_wall);
}

function fall(deltaTime)
{
	if(!grounded)
	{
		vsp = approach(vsp, vsp_max, grav*deltaTime );
		y+= vsp;
		
	}
}