COLUMN_STEP = 4
def part_one
  p "part one"
  stacks = []
  diagram_processed = false
  line_number = 0

  File.foreach('input.txt') do |line|
    diagram_processed = true if line[1] == '1'
    
    if diagram_processed
      next if line[0] != 'm'

      moves = line.split ' '
      number_to_move = moves[1].to_i
      old_stack = moves[3].to_i - 1
      new_stack = moves[5].to_i - 1

      number_to_move.times { stacks[new_stack].prepend stacks[old_stack].shift }
    else
      line_arr = line.split('')

      (1...line_arr.size).step(COLUMN_STEP).each do |index|
        character = line_arr[index]

        current_stack = index / COLUMN_STEP
        stacks[current_stack] = [] if stacks[current_stack].nil?

        stacks[current_stack] << character if character != ' '
      end
    end
  end

  top_crates = stacks.reduce('') { |result, stack| result += stack.first }

  p top_crates
end

def part_two
  p "part two"

  stacks = []
  diagram_processed = false
  line_number = 0

  File.foreach('input.txt') do |line|
    diagram_processed = true if line[1] == '1'
    
    if diagram_processed
      next if line[0] != 'm'
      moves = line.split ' '

      number_to_move = moves[1].to_i
      old_stack = moves[3].to_i - 1
      new_stack = moves[5].to_i - 1

      stacks[new_stack].prepend stacks[old_stack].shift(number_to_move)
      stacks[new_stack].flatten!
    else
      line_arr = line.split('')

      (1...line_arr.size).step(COLUMN_STEP).each do |index|
        character = line_arr[index]

        current_stack = index / COLUMN_STEP
        stacks[current_stack] = [] if stacks[current_stack].nil?

        stacks[current_stack] << character if character != ' '
      end
    end
  end

  top_crates = stacks.reduce('') { |result, stack| result += stack.first }

  p top_crates
end

part_two
