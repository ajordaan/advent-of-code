def tree_visible?(grid, row, col)
  edge_tree = row == 0 || row == ROW_SIZE - 1 || col == 0 || col == COL_SIZE - 1
  return true if edge_tree
  
  visible_directions = DIRECTIONS.map { |direction| tree_visible_in_direction? grid, row, col, direction }
  visible_directions.any? 
end

def tree_visible_in_direction?(grid, row, col, direction)
  tree_height = grid[row][col]
  case direction
  when :up
    index = row - 1
    trees = []
    while index >= 0
      trees << grid[index][col]
      index -= 1
    end
    return trees.all? { |tree| tree < tree_height }
  when :down
    index = row + 1
    trees = []
    while index < ROW_SIZE
      trees << grid[index][col]
      index += 1
    end
    return trees.all? { |tree| tree < tree_height }
  when :left
    index = col - 1
    trees = []
    while index >= 0
      trees << grid[row][index]
      index -= 1
    end
    return trees.all? { |tree| tree < tree_height }
  when :right
    index = col + 1
    trees = []
    while index < COL_SIZE
      trees << grid[row][index]
      index += 1
    end
    return trees.all? { |tree| tree < tree_height }
  end
end

tree_grid = File.readlines('input.txt').map {|line| line.strip.chars}

ROW_SIZE = tree_grid.size
COL_SIZE = tree_grid.first.size

DIRECTIONS = [:up, :down, :left, :right]

visible_tree_count = 0

tree_grid.each_with_index do |trees, row|
  trees.each_with_index do |tree, col|
    if tree_visible? tree_grid, row, col
      visible_tree_count += 1
    end
  end
end

puts "Trees Visible: "
p visible_tree_count
