if (keyboard_check_pressed(vk_up))
{
    selected_choice = max(0, selected_choice - 1);
}

if (keyboard_check_pressed(vk_down))
{
    selected_choice = min(
        array_length(current_node.choices) - 1,
        selected_choice + 1
    );
}

if (keyboard_check_pressed(vk_enter))
{
    if (array_length(current_node.choices) == 0) exit;

    var choice = current_node.choices[selected_choice];

    // 🔔 Broadcast event if defined
    if (choice.event != "")
    {
        global.event_bus.emit(choice.event, {
            speaker : current_node.speaker,
            node    : current_node,
            choice  : choice
        });
    }

    current_node = global.dialogue[? choice.next];
    selected_choice = 0;
}
