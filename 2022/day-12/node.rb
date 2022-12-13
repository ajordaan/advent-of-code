class Node
  def initialize(id:, value:, row:, col:)
    @value = value
    @siblings = []
    @visited = false
    @row = row
    @col = col
    @id = id
  end

  attr_accessor :value, :siblings, :visited, :row, :col, :id

  def self.grid_values

  end

  def add_sibling(row, col)
    @siblings << "#{row}#{col}"
  end

  def position
    "#{row}#{col}"
  end

  def to_s
    sibs = siblings.map {|s| s }
    "#{value} -> #{sibs}"
  end

  def visited!
    visited = true
  end

  def visited?
    visited
  end

  def ==(other)
    other.row == row && other.col == col
  end

  def eql?(other)
    other.row == row && other.col == col
  end

  def hash
    [row, col].hash
  end

  
end
