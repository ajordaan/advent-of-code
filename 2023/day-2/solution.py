import math

RED_CUBES = 12
GREEN_CUBES = 13
BLUE_CUBES = 14


def part_one(filename):
    # only 12 red cubes, 13 green cubes, and 14 blue cubes

    with open(filename) as f:
        cube_display_counts = []
        sum = 0
        for game in f:
            game_parts = game.split(":")
            game_id = extract_game_id(game_parts[0])
            cube_displays = game_parts[1].split(";")
            cube_display_counts = list(map(extract_cube_details, cube_displays))
            if game_is_valid(cube_display_counts):
                sum += game_id

            print(cube_display_counts)
        print(sum)


def part_two(filename):
    with open(filename) as f:
        cube_display_counts = []
        sum = 0
        for game in f:
            game_parts = game.split(":")
            cube_displays = game_parts[1].split(";")
            cube_display_counts = list(map(extract_cube_details, cube_displays))
            fewest_cubes_counts = fewest_cubes(cube_display_counts)
            power_set = math.prod(fewest_cubes_counts.values())
            sum += power_set

            print(cube_display_counts)
            print(fewest_cubes_counts)

        print(sum)


def fewest_cubes(cube_displays):
    cubes = {"red": 0, "green": 0, "blue": 0}
    for cube_display in cube_displays:
        cubes["red"] = max(cube_display.get("red", 0), cubes["red"])
        cubes["green"] = max(cube_display.get("green", 0), cubes["green"])
        cubes["blue"] = max(cube_display.get("blue", 0), cubes["blue"])
    return cubes


def game_is_valid(cube_displays):
    for cube_display in cube_displays:
        if (
            cube_display.get("red", 0) > RED_CUBES
            or cube_display.get("green", 0) > GREEN_CUBES
            or cube_display.get("blue", 0) > BLUE_CUBES
        ):
            return False
    return True


def extract_game_id(game_info: str):
    number = ""
    for char in game_info:
        if char.isdigit():
            number += char

    return int(number)


def extract_cube_details(cube_displays: str):
    # 3 blue, 4 red
    cube_display = {}
    for cube_details in cube_displays.split(","):
        cube_number, cube_colour = cube_details.strip().split(" ")

        cube_display[cube_colour] = int(cube_number)
    return cube_display


part_two("input.txt")
