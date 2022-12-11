require 'set'

class Position

  DIRECTIONS = { U: { coordinate: :y, operator: :+ }, D: { coordinate: :y, operator: :- }, L: { coordinate: :x, operator: :- }, R: { coordinate: :x, operator: :+ } }

  def initialize(x: 0,y: 0, name:)
    @x = x
    @y = y
    @name = name

    @moves = Set.new
  end

  attr_reader :x, :y, :name, :moves

  def move(direction)
    move_direction = DIRECTIONS[direction.to_sym]
    update_coordinate move_direction[:coordinate], move_direction[:operator]
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

  def below?
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
    "#{name} (x: #{@x}, y: #{@y})"
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
