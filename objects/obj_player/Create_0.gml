move_speed = 1;

facing = 0;

energy = 100;
hygiene = 100;
food = 100;
rizz = 50;
sanity = 100;

grade_one = 70;
grade_two = 70;
grade_three = 70;

board_swipes = 12;
flex_swipes = 2;

fade_alpha = 0;

global.draw_primary_ui = true;
global.ending = "";
global.skipHourAfterDialogue = false;

first = true;

function sleep() {
    energy = min(100, energy + 40);
    sanity += random(10) - 5;
}

function study() {
    energy -= 5;
    sanity += random(10) - 5;
    grade_one = min(100, grade_one + random(30));
    grade_two = min(100, grade_two + random(30));
    grade_three = min(100, grade_three + random(30));
}

global.show_dialogue_and_pause = function(_text, _duration, _skipHour) {
    // 1. Trigger your existing pause system
    global.paused = true;
    
    // 2. Set the text you want your UI object to draw
    global.npc_dialog = _text;
    
    global.skipHourAfterDialogue = _skipHour;
    
    // 3. Create the timer to "resume"
    // We use a Time Source so we don't have to manage variables in a Step event
    var _resume_timer = time_source_create(time_source_game, _duration, time_source_units_seconds, function() {
        global.npc_dialog = ""; // Clear the text when the time is up
        if global.skipHourAfterDialogue global.skipHour();
        global.paused = false;
    });
    
    time_source_start(_resume_timer);
}
