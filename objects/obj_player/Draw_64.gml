function scr_fade_and_exit() {
    // 1. Draw the black overlay
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1); // Reset alpha for other drawing

    // 2. Increase darkness for the next frame
    fade_alpha += 0.02; 

    // 3. THE "YIELD": If we are fully black, stop the logic here
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        return; // Exits the function immediately; code below this won't run
    }
    
    // Any code here only runs while the screen is still partially transparent
    show_debug_message("Still fading...");
}

if (!global.draw_primary_ui) {
    if (global.ending != "") {
        scr_fade_and_exit();
        if (fade_alpha >= 1) { 
            var default_font = draw_get_font();
            draw_set_font(EndFont);
            draw_set_colour(c_white);
            
            var print_string = "GAME OVER: " + global.ending;
            
            draw_text(display_get_gui_width() / 2 - string_width(print_string) / 2, display_get_gui_height() / 2, print_string);
            
            draw_set_font(default_font);
            draw_set_colour(c_black);
        }
    }
    exit;
}    

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
