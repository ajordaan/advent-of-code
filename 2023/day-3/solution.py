import math
from typing import List, Tuple


def part_one(filename):
    engine = []
    part_numbers = set()
    with open(filename) as f:
        for line in f:
            engine.append(list(line))
    for i, row in enumerate(engine):
        for k, character in enumerate(row):
            if char_is_symbol(character):
                number_indexes = find_adjacent_number_indexes(engine, i, k)
                for index in number_indexes:
                    number, visited_indexes = extract_number_from_index(engine, index)
                    part_numbers.add((number, tuple(visited_indexes)))

    parts = [t[0] for t in part_numbers]

    print(parts)
    print(sum(parts))


def char_is_symbol(char) -> bool:
    if char == "." or char == "" or char == "\n":
        return False

    if char.isascii() and not char.isalnum():
        return True

    return False


def extract_number_from_index(
    engine: List[List[str]], index: Tuple[int, int]
) -> Tuple[int, List[Tuple[int, int]]]:
    row = index[0]
    col = index[1]
    visited_indexes: List[Tuple[int, int]] = []

    char = engine[row][col]
    while char.isdigit():
        col -= 1
        char = engine[row][col]

    col += 1

    char = engine[row][col]
    number_chars = ""
    while char.isdigit():
        number_chars += char
        visited_indexes.append((row, col))
        col += 1
        char = engine[row][col]

    return (int(number_chars), visited_indexes)


def find_adjacent_number_indexes(engine, row, col) -> List[Tuple[int, int]]:
    # 0   (0,0) (0,1) (0,2)
    # 1   (1,0) (1,1) (1,2)
    # 2   (2,0) (2,1) (2,2)

    indexes: List[Tuple[int, int]] = [
        (row - 1, col - 1),
        (row - 1, col),
        (row - 1, col + 1),
        (row, col - 1),
        (row, col),
        (row, col + 1),
        (row + 1, col - 1),
        (row + 1, col),
        (row + 1, col + 1),
    ]

    indexes_with_numbers = list(
        filter(lambda coords: element_is_number(engine, coords[0], coords[1]), indexes)
    )

    return indexes_with_numbers


def element_is_number(engine, row, col) -> bool:
    try:
        element = engine[row][col]
        return element.isdigit()
    except IndexError:
        return False


def part_two(filename):
    pass


part_one("input.txt")
