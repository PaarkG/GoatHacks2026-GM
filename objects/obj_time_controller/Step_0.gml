if (global.paused) exit;

timer += delta_time * time_scale;

// QUARTER HOUR
if (timer >= next_quarter)
{
    next_quarter += quarter_interval;
}

// HOUR
if (timer >= next_hour)
{
    array_foreach(global.on_hour, function(func) {
        if (is_callable(func)) {
            func();
        }
    })
    
    next_hour += hour_interval;
}

// DAY END (20 HOURS)
if (timer >= next_day)
{
    global.endDay();
}
