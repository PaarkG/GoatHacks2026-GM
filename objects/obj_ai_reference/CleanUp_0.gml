// ===== CLEANUP (Put in Clean Up event) =====

if (global.current_sound != -1) {
    audio_destroy_stream(global.current_sound);
}

if (file_exists(global.audio_file_path)) {
    file_delete(global.audio_file_path);
}
