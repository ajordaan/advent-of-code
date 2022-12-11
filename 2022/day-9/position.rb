require 'set'

class Position

  DIRECTIONS = { U: { coordinate: :y, operator: :+ }, D: { coordinate: :y, operator: :- }, L: { coordinate: :x, operator: :- }, R: { coordinate: :x, operator: :+ } }

  def initialize(x: 0,y: 0, name:, follower: nil )
    @x = x
    @y = y
    @name = name
    @follower = follower

    @moves = Set.new
  end

  attr_reader :x, :y, :name, :moves
  attr_accessor :follower

  def move(direction)
    move_direction = DIRECTIONS[direction.to_sym]
    update_coordinate move_direction[:coordinate], move_direction[:operator]

    follower.follow self if follower
  end

  def follow(leader)
    if name == 2
      puts '2 following'

      puts leader.to_s
      puts to_s
    end
    return if next_to? leader
  
    puts 'moving 2' if name == 2
    if in_same_row? leader
      puts 'in same row as 1' if name == 2
      move(below?(leader) ? :U : :D)
    elsif in_same_column? leader
      puts 'in same column as 1' if name == 2
      move(left_of?(leader) ? :R : :L)
    else
        puts 'in different row' if name == 2
      if below? leader
        puts '2 is below' if name == 2
        move :U
      else
        move :D
      end
        move(left_of?(leader) ? :R : :L)
    end
  
    count_move "(#{x},#{y})"
  end

  def count_move(coords)
    @moves << coords
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def next_to?(other)
    (y - other.y).abs <= 1 && (x - other.x).abs <= 1
  end

  def above?(other)
    y > other.y
  end

  def below?(other)
    y < other.y
  end

  def in_same_row?(other)
    x == other.x
  end

  def in_same_column?(other)
    y == other.y
  end

  def left_of?(other)
    x < other.x
  end

  def right_of?(other)
    x > other.x
  end

  def to_s
    "#{name} (x: #{@x}, y: #{@y}) Follower: #{@follower&.name}"
  end

  private 

  def update_coordinate(coordinate, operator)
    case coordinate
    when :x
      @x = @x.send(operator, 1)
    when :y
      @y = @y.send(operator, 1)
    end
  end
end
