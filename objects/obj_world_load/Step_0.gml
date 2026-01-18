if placed exit;
    
if instance_exists(obj_player) {
    obj_player.x = global.tp_x;
    obj_player.y = global.tp_y;
    placed = true;
}