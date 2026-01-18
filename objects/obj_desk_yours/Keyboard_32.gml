if global.paused exit;

if (abs(obj_player.x - x) < 30 && abs(obj_player.y - y) < 20) {
    global.show_dialogue_and_pause("Studying isn't for the weak... ugh.", 3, true);
}
