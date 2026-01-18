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

first = true;

function sleep() {
    energy = min(100, energy + 40);
    sanity += random(10) - 5;
}
