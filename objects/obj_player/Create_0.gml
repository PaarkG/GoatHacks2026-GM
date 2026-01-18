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

function study() {
    energy -= 5;
    sanity += random(10) - 5;
    grade_one = min(100, grade_one + random(30));
    grade_two = min(100, grade_two + random(30));
    grade_three = min(100, grade_three + random(30));
}
