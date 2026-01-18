if (sleeping) exit;

if (abs(obj_player.x - x) < 15 && abs(obj_player.y - y) < 15) {
    sleeping = true;
    
    global.endDay();
    
    obj_player.sleep();
    
    alarm[0] = 100;
}