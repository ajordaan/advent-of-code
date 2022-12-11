require_relative 'position'

def part_one
  head = Position.new x: 100, y: 100, name: 'H'
  tail = Position.new x: 100, y: 100, name: 'T', follows: head

  tail.count_move "(100,100)"

  puts "== INITIAL STATE ==\n"
  print_grid [head, tail]
  puts ' '
  File.foreach('example_input.txt') do |l|

    direction, distance = l.split ' '
    distance = distance.to_i
    puts "== #{direction} #{distance} =="

    distance.times do
      head.move direction
      update_tail head, tail

      puts ' '
      print_grid [head, tail]
      puts ' '
    end
  end

  puts "Moves: "
  puts tail.moves.size
end


def update_tail(head, tail)
  return if head.next_to? tail

  if head.in_same_row? tail
    tail.move(head.above?(tail) ? :U : :D)
  elsif head.in_same_column? tail
    tail.move(head.right_of?(tail) ? :R : :L)
  else
    if head.above? tail
      tail.move :U
    else
      tail.move :D
    end
      tail.move(head.right_of?(tail) ? :R : :L)
  end

  tail.count_move "(#{tail.x},#{tail.y})"
end


def print_grid(knots, start = 100)
  (start + 4).downto(start) do |r|
    start.upto(start + 6) do |c|
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
