var w = 76;
var h = 28;
var padding_top = 10;
var padding_right = 10;

var scale = 8;

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

var curr_hour = floor(timer / HOUR);
var curr_minute = floor((timer % HOUR) / MINUTE);

var minute_str = string(curr_minute);
if (curr_minute < 10) minute_str = "0" + minute_str;

var text_padding_x = 5 * scale;
var text_padding_y = 4 * scale;

draw_text_transformed(dx + text_padding_x, dy + text_padding_y, 
    string(curr_hour) + ":" + minute_str, 
    scale, 
    scale, 
    0
);

draw_set_font(old_font);
draw_set_halign(old_halign);
draw_set_valign(old_valign);
