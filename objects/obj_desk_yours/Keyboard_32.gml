if (studying) exit;

if (abs(obj_player.x - x) < 30 && abs(obj_player.y - y) < 20) {
    studying = true;
    
    alarm[0] = 100;
}
