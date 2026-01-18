#macro SECOND 1000000
#macro MINUTE (60 * SECOND)
#macro HOUR (60 * MINUTE)

timer = 0;
paused = false;

time_scale = 100;
hour_offset = 8;

quarter_interval = 15 * MINUTE;
hour_interval = 1 * HOUR;
day_interval = 20 * HOUR;

next_quarter = quarter_interval;
next_hour = hour_interval;
next_day = day_interval;

days = 0;

global.on_day_end = [];
global.on_hour = [];

global.pauseTime = function() {
    paused = true;
}

global.resumeTime = function() {
    paused = false;
}

gpu_set_texfilter(false);
