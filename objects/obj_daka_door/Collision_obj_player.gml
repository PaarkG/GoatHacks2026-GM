if !enabled exit;

enabled = false;

if obj_player.board_swipes > 0 || obj_player.flex_swipes > 0 {
    global.show_dialogue_and_pause("You got food poisoning! +40", 5, false);
    obj_player.food = min(100, obj_player.food + 40);
    if obj_player.board_swipes <= 0 obj_player.flex_swipes--;
    if obj_player.board_swipes > 0 obj_player.board_swipes--;
} else {
    global.show_dialogue_and_pause("No more swipes! Good luck... +5", 5, false);
    obj_player.food = min(100, obj_player.food + 5);
}

alarm[0] = 5000;