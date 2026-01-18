if (paused) exit;

timer += delta_time * time_scale;

// QUARTER HOUR
if (timer >= next_quarter)
{
    global.event_bus.emit("quarter_hour", next_quarter / quarter_interval);
    next_quarter += quarter_interval;
}

// HOUR
if (timer >= next_hour)
{
    global.event_bus.emit("hour", next_hour / hour_interval);
    next_hour += hour_interval;
}

// DAY END (20 HOURS)
if (timer >= next_day)
{
    global.event_bus.emit("day_end", -1);

    paused = true;

    timer = 0;
    next_quarter = quarter_interval;
    next_hour = hour_interval;
    next_day = day_interval;
}
