var horizontal = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vertical = keyboard_check(ord("S")) - keyboard_check(ord("W"));

move_and_collide(horizontal * walkspeed, vertical * walkspeed, all);
