if (first) {
    first = false;
    
    array_push(global.on_hour, function() {
        energy -= 5;
        hygiene -= 5;
        food -= 5;
        sanity -= 5;
        
        grade_one -= 2;
        grade_two -= 2;
        grade_three -= 2;
    });
}

function trigger_no_energy() {
    global.paused = true;
    global.draw_primary_ui = false;
    global.ending = "You fade into a deep sleep, and wake up with 3 NR's";
}

function trigger_no_hygiene() {
    global.paused = true;
    global.draw_primary_ui = false;
    global.ending = "You stunk yourself to death... that' a first!";
}

function trigger_no_food() {
    global.paused = true;
    global.draw_primary_ui = false;
    global.ending = "I got hungry watching you play this game...";
}

function trigger_no_sanity() {
    global.paused = true;
    global.draw_primary_ui = false;
    global.ending = "RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH️";
}

if (energy <= 0) {
    trigger_no_energy();
} else if (hygiene <= 0) {
    trigger_no_hygiene();
} else if (food <= 0) {
    trigger_no_food();
} else if (sanity <= 0) {
    trigger_no_sanity();
}

if (global.paused) exit;

var _hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _ver = keyboard_check(ord("S")) - keyboard_check(ord("W"));

move_and_collide(_hor * move_speed, _ver * move_speed, [layer_tilemap_get_id("Walls"), layer_tilemap_get_id("CollisionFurniture")], undefined, undefined, undefined, move_speed, move_speed);

if (_hor != 0 or _ver != 0) {
    if (_ver > 0) {
        sprite_index = spr_player_walk_down;
    } else if (_ver < 0) {
        sprite_index = spr_player_walk_up;
    } else if (_hor > 0) {
        sprite_index = spr_player_walk_right
    } else {
        sprite_index = spr_player_walk_left;
    }
    
    facing = point_direction(0, 0, _hor, _ver);
} else {
    if (sprite_index == spr_player_walk_down) {
        sprite_index = spr_player_idle_down;
    } else if (sprite_index == spr_player_walk_up) {
        sprite_index = spr_player_idle_up;
    } else if (sprite_index == spr_player_walk_right) {
        sprite_index = spr_player_idle_right;
    } else if (sprite_index == spr_player_walk_left) {
        sprite_index = spr_player_idle_left;
    }
}
