/// @desc

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
        case "player_fly":
            play_sound(snd_player_fly);
        break;
    }
}



