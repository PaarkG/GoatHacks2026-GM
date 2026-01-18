if (keyboard_check_pressed(vk_space)) {
    obj_player.grade_one = 45;
    obj_player.grade_two = 50;
    obj_player.grade_three = 55;
    global.generate_ai_dialog("professor");
}