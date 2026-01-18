function DialogueNode(_speaker, _text, _choices)
{
    return {
        speaker : _speaker,
        text    : _text,
        choices : _choices
    };
}

function DialogueChoice(_text, _next, _event = "")
{
    return {
        text  : _text,
        next  : _next,
        event : _event // optional broadcast
    };
}

global.dialogue = {

    start : DialogueNode(
        "Keeper",
        "What brings you here?",
        [
            DialogueChoice("I'm looking for work.", "job", "ask_for_job"),
            DialogueChoice("Just passing through.", "pass", "ignore_npc")
        ]
    ),

    job : DialogueNode(
        "Keeper",
        "Then I may have a task for you.",
        [
            DialogueChoice("I'll do it.", "accept", "quest_accepted"),
            DialogueChoice("Not interested.", "end", "quest_refused")
        ]
    ),

    pass : DialogueNode(
        "Keeper",
        "Then don't linger.",
        [
            DialogueChoice("Leave.", "end")
        ]
    ),

    accept : DialogueNode(
        "Keeper",
        "Meet me at dusk.",
        []
    ),

    final : DialogueNode(
        "",
        "The conversation ends.",
        []
    )
};
