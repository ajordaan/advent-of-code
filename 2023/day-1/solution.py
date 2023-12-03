def part_one(filename):
    digits = []

    with open(filename) as f:
        for line in f:
            first_digit = None
            last_digit = None
            for c in line:
                if c.isdigit():
                    first_digit = c
                    break
            for c in reversed(line):
                if c.isdigit():
                    last_digit = c
                    break
            if first_digit != None and last_digit != None:
                digits.append(int(first_digit + last_digit))
    print(sum(digits))

def convert_to_number(val:str):
    number_words = ['placeholder', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

    if val.isdigit():
      return str(val)
    else:
        return str(number_words.index(val))


def part_two(filename):
    digits = []
    first_digit = {}
    last_digit = {}
    number_words = ['placeholder', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    with open(filename) as f:
        for line in f:
            number_word_indexes_forwards = list(map(lambda num_word: { 'value': num_word, 'index': line.find(num_word) }, number_words) )
            number_word_indexes_backwards = list(map(lambda num_word: { 'value': num_word, 'index': line.rfind(num_word) }, number_words) )
            first_digit = None
            last_digit = None
            for c in line:
                if c.isdigit():
                    first_digit = { 'value': c, 'index': line.find(c) }
                    break

            for c in reversed(line):
                if c.isdigit():
                    last_digit = { 'value': c, 'index': line.rfind(c) }
                    break
            if first_digit != None and last_digit != None:
                digits.append(number_word_indexes_forwards + number_word_indexes_backwards + [first_digit, last_digit])
            else:
                digits.append(number_word_indexes_forwards + number_word_indexes_backwards)

        line_numbers = []
        for line_info in digits:
            found_numbers = list(filter(lambda x: x['index'] > -1, line_info))
            print(f'Filtered Line Info: {found_numbers}')
            first_digit = min(found_numbers, key=lambda x: x['index'])
            last_digit = max(found_numbers, key=lambda x: x['index'])
            print(f'First digit {first_digit}, last digit {last_digit}')
            print('')

            final_number = convert_to_number(first_digit['value']) + convert_to_number(last_digit['value'])
            line_numbers.append(final_number)


    print(line_numbers)
    print(sum(list(map(int, line_numbers))))

part_two('input.txt')

