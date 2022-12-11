require_relative 'position'

def part_one
  head = Position.new x: 100, y: 100, name: 'head'
  tail = Position.new x: 100, y: 100, name: 'tail'

  tail.count_move "(100,100)"

  puts "== INITIAL STATE ==\n"
  print_grid head, tail
  puts ' '
  File.foreach('input.txt') do |l|

    direction, distance = l.split ' '
    distance = distance.to_i
    puts "== #{direction} #{distance} =="

    distance.times do
      head.move direction
      update_tail head, tail

      puts ' '
      # print_grid head, tail
      puts ' '

    end
    
  end

  puts "Moves: "
  puts tail.moves
  puts tail.moves.size
end


def update_tail(head, tail)
  return if head.next_to? tail

  if head.in_same_row? tail
    case head.y - tail.y
    when 2 then tail.move :U
    when -2 then tail.move :D
    end
  elsif head.in_same_column? tail
    case head.x - tail.x
    when 2 then tail.move :R
    when -2 then tail.move :L
    end
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


def print_grid(head, tail)
  4.downto(0) do |r|
    6.times do |c|
      if head.x == c && head.y == r 
        print 'H'
      elsif tail.x == c && tail.y == r
        print 'T'
      else
        print '.'
      end

    end
    puts ' '
  end
end

part_one
