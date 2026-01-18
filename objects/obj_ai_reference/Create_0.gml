global.text_request = -1;
global.audio_request = -1;
global.audio_file_path = "";
global.current_sound = -1;
global.current_voice_id = "21m00Tcm4TlvDq8ikWAM"; // Default voice

// Dialog display
global.player_dialog = "";
global.npc_dialog = "";
global.pending_npc_text = "";
global.dialog_timer = 0;

// ===== MAIN FUNCTION: Generate AI Dialog and Play =====

global.generate_ai_dialog = function(relationship, voice_id) {
    global.paused = true;
    
    /*
    Generates contextual dialog based on game stats and plays it as speech
    
    relationship: "professor", "friend", "roommate", "romantic_interest", etc.
    voice_id: ElevenLabs voice ID (e.g., "21m00Tcm4TlvDq8ikWAM" for Rachel)
    
    Example usage:
        generate_ai_dialog("professor", "21m00Tcm4TlvDq8ikWAM");
        generate_ai_dialog("friend", "pNInz6obpgDQGcFmaJgB");
    */
    
    // Store voice_id for later use in TTS
    global.current_voice_id = voice_id;
    
    // Build URL with all game stats
    var url = "http://localhost:5000/generate_response";
    url += "?relationship=" + relationship;
    url += "&energy=" + string(obj_player.energy);
    url += "&hygiene=" + string(obj_player.hygiene);
    url += "&food=" + string(obj_player.food);
    url += "&rizz=" + string(obj_player.rizz);
    url += "&sanity=" + string(obj_player.sanity);
    url += "&grade_one=" + string(obj_player.grade_one);
    url += "&grade_two=" + string(obj_player.grade_two);
    url += "&grade_three=" + string(obj_player.grade_three);
    
    // Request the AI-generated text
    global.text_request = http_get(url);
    
    show_debug_message("Requesting AI dialog for: " + relationship + " with voice: " + voice_id);
}

// ===== HELPER FUNCTION: Play TTS (internal use) =====

function play_tts(text) {
    // Clean up previous audio
    if (global.current_sound != -1) {
        audio_stop_sound(global.current_sound);
        audio_destroy_stream(global.current_sound);
        global.current_sound = -1;
    }
    
    // Delete old temp file
    if (file_exists(global.audio_file_path)) {
        file_delete(global.audio_file_path);
    }
    
    // Create new temp file path
    global.audio_file_path = temp_directory + "tts_" + string(current_time) + ".ogg";
    
    // URL encode the text
    var encoded_text = text;
    encoded_text = string_replace_all(encoded_text, " ", "%20");
    encoded_text = string_replace_all(encoded_text, "?", "%3F");
    encoded_text = string_replace_all(encoded_text, "!", "%21");
    encoded_text = string_replace_all(encoded_text, ",", "%2C");
    encoded_text = string_replace_all(encoded_text, ".", "%2E");
    encoded_text = string_replace_all(encoded_text, "'", "%27");
    encoded_text = string_replace_all(encoded_text, "&", "%26");
    
    // Build URL with text and voice_id
    var url = "http://localhost:5000/tts";
    url += "?text=" + encoded_text;
    url += "&voice_id=" + global.current_voice_id;
    global.audio_request = http_get_file(url, global.audio_file_path);
    
    show_debug_message("Generating TTS: " + text + " (Voice: " + global.current_voice_id + ")");
}