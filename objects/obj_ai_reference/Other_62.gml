// Handle text generation response
if (async_load[? "id"] == global.text_request) {
    // 1. Check status first! 0 = success, 1 = in progress, <0 = error
    var status = async_load[? "status"];
    
    if (status == 0) {
        var result = async_load[? "result"];
        
        // 2. Safety: Ensure result isn't undefined before using it
        if (!is_undefined(result)) {
            // Use string() to be safe when adding to another string
            show_debug_message("Received AI response: " + string(result));
            
            // Parse the JSON response
            var json = json_parse(result);
            
            if (is_struct(json) && variable_struct_exists(json, "success") && json.success) {
                // Inside the if (json.success) block:
                var player_text = json.player_text;
                var npc_text = json.npc_text;
                var rizz_change = json.rizz_change;
                
                global.player_dialog = player_text;
                global.pending_npc_text = npc_text; // <--- SAVE THIS HERE
                global.npc_dialog = "";
                
                show_debug_message("Player says: " + string(player_text));
                show_debug_message("NPC says: " + string(npc_text));
                show_debug_message("Rizz change: " + string(rizz_change));
                
                // Display player dialogue immediately
                global.player_dialog = player_text;
                global.dialog_timer = 300; 
                
                alarm[0] = global.dialog_timer;
                
                obj_player.rizz = clamp(obj_player.rizz + rizz_change, 0, 100);
                
                if (rizz_change > 0) {
                    show_debug_message("Rizz increased! New rizz: " + string(obj_player.rizz));
                } else if (rizz_change < 0) {
                    show_debug_message("Rizz decreased. New rizz: " + string(obj_player.rizz));
                }
                
                play_tts(npc_text);
            } else {
                show_debug_message("ERROR: AI generation failed or JSON invalid");
                if (is_struct(json) && variable_struct_exists(json, "error")) {
                    show_debug_message("Error: " + string(json.error));
                }
            }
        }
        
        // Reset request ID only after the final status is handled
        global.text_request = -1;
        
    } else if (status < 0) {
        show_debug_message("HTTP Request Failed with status: " + string(status));
        global.text_request = -1;
    }
}

// Handle TTS audio download (Keep your existing logic, but add status checks)
if (async_load[? "id"] == global.audio_request) {
    var status = async_load[? "status"];
    var http_status = async_load[? "http_status"];
    
    if (status == 0 && http_status == 200) {
        if (file_exists(global.audio_file_path)) {
            var test_buffer = buffer_load(global.audio_file_path);
            if (buffer_exists(test_buffer)) {
                var file_size = buffer_get_size(test_buffer);
                buffer_delete(test_buffer);
                
                show_debug_message("Audio downloaded! Size: " + string(file_size) + " bytes");
                
                if (global.current_sound != -1) audio_stop_sound(global.current_sound);
                global.current_sound = audio_create_stream(global.audio_file_path);
                
                if (global.current_sound != -1) {
                    audio_play_sound(global.current_sound, 1, false);
                    global.npc_dialog = global.pending_npc_text;
                    global.dialog_timer = 300; 
                }
            }
        }
        global.audio_request = -1;
    } else if (status < 0) {
        show_debug_message("ERROR: Audio download failed, HTTP: " + string(http_status));
        global.audio_request = -1;
    }
}

global.paused = false;