var horizontal = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vertical = keyboard_check(ord("S")) - keyboard_check(ord("W"));

move_and_collide(horizontal * walkspeed, vertical * walkspeed, layer_tilemap_get_id("Walls"));

if (horizontal != 0 || vertical != 0) {
    sprite_index = spr_player_walk;
} else {
    sprite_index = spr_player_idle;
}