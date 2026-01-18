if (async_load[? "id"] == global.text_request) {
    var result = async_load[? "result"];
    
    show_debug_message("Received AI response: " + result);
    
    // Parse the JSON response
    var json = json_parse(result);
    
    if (json.success) {
        var generated_text = json.text;
        show_debug_message("AI Generated: " + generated_text);
        
        // Now generate TTS for this text
        play_tts(generated_text);
    } else {
        show_debug_message("ERROR: AI generation failed");
        if (variable_struct_exists(json, "error")) {
            show_debug_message("Error: " + json.error);
        }
    }
    
    global.text_request = -1;
}

// Handle TTS audio download
if (async_load[? "id"] == global.audio_request) {
    var status = async_load[? "status"];
    var http_status = async_load[? "http_status"];
    
    if (status == 0 && http_status == 200) {
        if (file_exists(global.audio_file_path)) {
            // Check file size
            var test_buffer = buffer_load(global.audio_file_path);
            var file_size = buffer_get_size(test_buffer);
            buffer_delete(test_buffer);
            
            show_debug_message("Audio downloaded! Size: " + string(file_size) + " bytes");
            
            // Load and play
            global.current_sound = audio_create_stream(global.audio_file_path);
            
            if (global.current_sound != -1) {
                audio_play_sound(global.current_sound, 1, false);
                show_debug_message("Playing AI dialog!");
            } else {
                show_debug_message("ERROR: Failed to create audio stream");
            }
        }
    } else {
        show_debug_message("ERROR: Audio download failed, HTTP: " + string(http_status));
    }
    
    global.audio_request = -1;
}