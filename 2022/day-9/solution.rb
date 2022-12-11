require_relative 'position'

START_X = 0
START_Y = 0
NUMBER_OF_KNOTS = 9
def part_one
  tail = Position.new x: START_X, y: START_Y, name: 'T'
  head = Position.new x: START_X, y: START_Y, name: 'H', follower: tail

  tail.count_move "(#{START_X},#{START_Y})"

  knots = [head, tail]

  puts "== INITIAL STATE ==\n"
  print_grid knots
  puts ' '
  File.foreach('input.txt') do |l|

    direction, distance = l.split ' '
    distance = distance.to_i
    puts "== #{direction} #{distance} =="

    distance.times do
      head.move direction

      puts ' '
      print_grid knots
      puts ' '
    end
  end

  puts "Moves: "
  puts tail.moves.size
end

def part_two
  head = Position.new x: START_X, y: START_Y, name: 'H', follower: nil
  prev_knot = nil
  knots = []
  NUMBER_OF_KNOTS.downto(1) do |n|
   k = Position.new x: START_X, y: START_Y, name: n, follower: prev_knot
   knots << k
   prev_knot = k
  end

  head.follower = knots.last
  knots << head
  knots.reverse!

  knots.each {|k| k.count_move("#{START_X},#{START_Y}")}

  puts knots


  puts "== INITIAL STATE ==\n"
  print_grid knots
  puts ' '
  File.foreach('example_input.txt') do |l|

    direction, distance = l.split ' '
    distance = distance.to_i
    puts "== #{direction} #{distance} =="

    distance.times do
      head.move direction
      puts ' '
      print_grid knots
      puts ' '
    end
  end

  puts "Moves: "
  puts knots.last.moves.size
end

def print_grid(knots, start = START_X)
  (start + 4).downto(start) do |r|
    start.upto(start + 5) do |c|
      found_knot = knots.find { |k| k.x == c && k.y == r }

      if found_knot
        print found_knot.name
      else
        print '.'
      end
    end
    puts ' '
  end
end

part_one
