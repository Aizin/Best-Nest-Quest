/// @desc

if (mouse_wheel_up()) alpha = approach(alpha, 1, 0.05);
if (mouse_wheel_down()) alpha = approach(alpha, 0, 0.05);

if (mouse_check_button_pressed(mb_middle)) active = (active + 1) % 3;

