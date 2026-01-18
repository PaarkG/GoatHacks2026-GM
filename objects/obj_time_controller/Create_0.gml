global.event_bus = {
    listeners : ds_map_create(),

    subscribe : function(_event, _callback)
    {
        var list;

        if (!ds_map_exists(listeners, _event))
        {
            list = ds_list_create();
            ds_map_add(listeners, _event, list);
        }
        else
        {
            list = listeners[| _event];
        }

        ds_list_add(list, _callback);
    },

    emit : function(_event, _data)
    {
        if (!ds_map_exists(listeners, _event)) return;

        var list = listeners[| _event];
        for (var i = 0; i < ds_list_size(list); i++)
        {
            var func = list[| i];
            func(_data);
        }
    },

    destroy : function()
    {
        var keys = ds_map_keys(listeners);
        for (var i = 0; i < array_length(keys); i++)
        {
            ds_list_destroy(listeners[| keys[i]]);
        }
        ds_map_destroy(listeners);
    }
};

#macro SECOND 1000000
#macro MINUTE (60 * SECOND)
#macro HOUR (60 * MINUTE)

timer = 0;
paused = false;

time_scale = 100;

quarter_interval = 15 * MINUTE;
hour_interval = 1 * HOUR;
day_interval = 20 * HOUR;

next_quarter = quarter_interval;
next_hour = hour_interval;
next_day = day_interval;

global.event_bus.subscribe("resume_timer", function () {
    paused = false;
});

global.event_bus.subscribe("pause_timer", function () {
    paused = true;
})
