// ===== DRAW GUI EVENT =====
// Draw dialogue boxes if there's text to show

if (global.player_dialog != "" || global.npc_dialog != "") {
    var box_width = 800;
    var box_height = 40;
    var margin = 20;
    var y_pos = display_get_gui_height() - box_height - margin;
    var x_pos = (display_get_gui_width() - box_width) / 2;
    
    // Draw player dialogue box (top)
    if (global.player_dialog != "") {
        draw_set_color(c_blue);
        draw_set_alpha(0.8);
        draw_rectangle(x_pos, y_pos - box_height - 10, x_pos + box_width, y_pos - 10, false);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(x_pos + box_width/2, y_pos - box_height/2 - 10, "YOU: " + global.player_dialog);
    }
    
    // Draw NPC dialogue box (bottom) - only shows after audio starts
    if (global.npc_dialog != "") {
        draw_set_color(c_green);
        draw_set_alpha(0.8);
        draw_rectangle(x_pos, y_pos, x_pos + box_width, y_pos + box_height, false);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(x_pos + box_width/2, y_pos + box_height/2, "NPC: " + global.npc_dialog);
    }
    
    // Reset draw settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
