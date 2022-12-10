def edge_tree?(row, col)
  row == 0 || row == ROW_SIZE - 1 || col == 0 || col == COL_SIZE - 1
end

def tree_visible?(grid, row, col)
  return true if edge_tree? row, col
  
  visible_directions = DIRECTIONS.map { |direction| tree_visible_in_direction? grid, row, col, direction }
  visible_directions.any? 
end

def tree_visible_in_direction?(grid, row, col, direction)
  tree_height = grid[row][col]
  trees = case direction
    when :up
      index = row - 1
      trees = []
      while index >= 0
        trees << grid[index][col]
        index -= 1
      end
      trees
    when :down
      index = row + 1
      trees = []
      while index < ROW_SIZE
        trees << grid[index][col]
        index += 1
      end
      trees
    when :left
      index = col - 1
      trees = []
      while index >= 0
        trees << grid[row][index]
        index -= 1
      end
      trees
    when :right
      index = col + 1
      trees = []
      while index < COL_SIZE
        trees << grid[row][index]
        index += 1
      end
      trees
    end

  trees.all? { |tree| tree < tree_height }
end

def tree_score(grid, row, col)
  return 0 if edge_tree? row, col

  view_distance_scores = DIRECTIONS.map {|direction| tree_view_distance_in_direction grid, row, col, direction}
  view_distance_scores.reduce(:*)
end

def tree_view_distance_in_direction(grid, row, col, direction)
  tree_height = grid[row][col]
  trees = case direction
    when :up
      index = row - 1
      trees = []
      while index >= 0
        trees << grid[index][col]
        index -= 1
      end
     trees
    when :down
      index = row + 1
      trees = []
      while index < ROW_SIZE
        trees << grid[index][col]
        index += 1
      end
      trees
    when :left
      index = col - 1
      trees = []
      while index >= 0
        trees << grid[row][index]
        index -= 1
      end
      trees
    when :right
      index = col + 1
      trees = []
      while index < COL_SIZE
        trees << grid[row][index]
        index += 1
      end
      trees
  end

  score = 0
  for tree in trees
    score += 1
    break if tree >= tree_height
  end

  score
end

tree_grid = File.readlines('input.txt').map {|line| line.strip.chars}

ROW_SIZE = tree_grid.size
COL_SIZE = tree_grid.first.size

DIRECTIONS = [:up, :left, :down, :right]

visible_tree_count = 0
scenic_scores = []

tree_grid.each_with_index do |trees, row|
  trees.each_with_index do |tree, col|
    visible_tree_count += 1 if tree_visible? tree_grid, row, col
    scenic_scores << tree_score(tree_grid, row, col)
  end
end

puts "Trees Visible: "
p visible_tree_count

puts "Highest Scenic Score: "
p scenic_scores.max
