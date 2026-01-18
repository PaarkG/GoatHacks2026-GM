if (!global.draw_primary_ui) exit;

function daystring() {
    var dayname = "";
    
    switch (days) {
        case 0:
            dayname = "Monday";
            break;
        case 1:
            dayname = "Tuesday";
            break;
        case 2:
            dayname = "Wednesday";
            break;
        case 3:
            dayname = "Thursday"
            break;
        case 4:
            dayname = "Friday";
            break;
    }
    
    return dayname + ", Day " + string(days + 1);
}

var w = 200;
var h = 24;
var padding_top = 20;
var padding_right = 20;

var scale = 4;

var dx = surface_get_width(application_surface) - (w * scale) - padding_right;
var dy = padding_top;

draw_sprite_stretched(
    spr_ui_box, 
    -1, 
    dx, 
    dy, 
    w * scale, 
    h * scale
);

var text_scale = scale * 0.5;

var old_font = draw_get_font();
var old_halign = draw_get_halign();
var old_valign = draw_get_valign();

draw_set_font(Font1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var curr_hour = (floor(timer / HOUR) + hour_offset) % 24;
var curr_minute = floor((timer % HOUR) / MINUTE);

var hour_string = string(curr_hour);
if (curr_hour < 10) hour_string = " " + hour_string;

var minute_str = string(curr_minute);
if (curr_minute < 10) minute_str = "0" + minute_str;

var text_padding_x = 5 * scale;
var text_padding_y = 4 * scale;

draw_text_transformed(dx + text_padding_x, dy + text_padding_y, 
    hour_string + ":" + minute_str + " | " + daystring(), 
    scale, 
    scale, 
    0
);

draw_set_font(old_font);
draw_set_halign(old_halign);
draw_set_valign(old_valign);
