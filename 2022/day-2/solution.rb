## Opponent:
# A -> Rock
# B -> Paper
# C -> Scissors

# # Me
# X -> Rock
# Y -> Paper
# Z -> Scissors


require_relative 'hand_option'


rock = HandOption.new(type: :rock, score: 1)
paper = HandOption.new(type: :paper, score: 2)
scissors = HandOption.new(type: :scissors, score: 3)



rock.beats scissors
rock.loses_to paper

paper.beats rock
paper.loses_to scissors

scissors.beats paper
scissors.loses_to rock

opponent_keys = { A: rock, B: paper, C: scissors }

my_keys = { X: rock, Y: paper, Z: scissors }



def part_one(opponent_keys, my_keys)
  total_score = 0
  File.foreach('example_input.txt') do |line|

    round = line.split(' ')
    opponent_key = round[0]
    my_key = round[1]

    total_score += my_keys[my_key.to_sym].plays opponent_keys[opponent_key.to_sym]
  end

  puts "TOTAL SCORE: #{total_score}"
end

def part_two(opponent_keys, my_keys)
  outcome_keys = { X: :lose, Y: :draw, Z: :win }
  total_score = 0
  File.foreach('input.txt') do |line|
    round = line.split(' ')
    opponent_key = round[0]
    outcome = round[1]

    opponent_hand = opponent_keys[opponent_key.to_sym]

    my_hand = opponent_hand.option_needed_for_outcome outcome_keys[outcome.to_sym]

    total_score += my_hand.plays opponent_hand
  end

  puts "TOTAL SCORE: #{total_score}"
end

# part_one(opponent_keys, my_keys)
part_two(opponent_keys, my_keys)


