var bar_scale = 4;

var inner_xoffset = 50;
var inner_yoffset = 55;

var inner_height = 32;

function scale(property) {
    var inner_width = 212; 
    return property * (inner_width / 100);
}

draw_roundrect(10 + inner_xoffset, 10 + inner_yoffset, 10 + inner_xoffset + scale(sanity), 10 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_sanity_bar, -1, 10, 10, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 100 + inner_yoffset, 10 + inner_xoffset + scale(food), 100 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_food_bar, -1, 10, 100, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 190 + inner_yoffset, 10 + inner_xoffset + scale(hygiene), 190 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_hygeine_bar, -1, 10, 190, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 280 + inner_yoffset, 10 + inner_xoffset + scale(rizz), 280 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_rizz_bar, -1, 10, 280, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 370 + inner_yoffset, 10 + inner_xoffset + scale(grade_one), 370 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_class1_bar, -1, 10, 370, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 460 + inner_yoffset, 10 + inner_xoffset + scale(grade_two), 460 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_class2_bar, -1, 10, 460, bar_scale, bar_scale, 0, c_white, 1);

draw_roundrect(10 + inner_xoffset, 550 + inner_yoffset, 10 + inner_xoffset + scale(grade_three), 550 + inner_yoffset + inner_height, false);
draw_sprite_ext(spr_class3_bar, -1, 10, 550, bar_scale, bar_scale, 0, c_white, 1);
