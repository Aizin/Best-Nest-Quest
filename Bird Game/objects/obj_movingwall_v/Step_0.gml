/// @description Insert description here
// You can write your code in this editor

image_xscale = dir;

if (x > endx) {
	dir = -1;
}
if (x < startx) {
	dir = 1;
}

x += hsp*dir;