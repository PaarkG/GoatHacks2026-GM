if !enabled exit;
    
enabled = false;

if obj_player.flex_swipes > 0 {
    global.show_dialogue_and_pause("Wow, that was good! +75", 5, false);
    obj_player.food = min(100, obj_player.food + 75);
    obj_player.flex_swipes--;
} else {
    global.show_dialogue_and_pause("No more flex swipes! Good luck...", 5, false);
    global.skipHour();
    global.paused = false;
}

alarm[0] = 5000;
