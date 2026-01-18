if (paused) exit;

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
    paused = true;
    
    array_foreach(global.on_day_end, function(func) {
        if (is_callable(func)) {
            func();
        }
    })

    timer = 0;
    next_quarter = quarter_interval;
    next_hour = hour_interval;
    next_day = day_interval; 
    
    days++;
}
