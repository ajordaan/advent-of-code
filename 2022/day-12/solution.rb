
def init
  grid = File.readlines('input.txt').map {|line| line.strip.chars}
p grid
nodes = []
id = 1

grid_values = {}
node_siblings = {}

start = nil
dest = nil
grid.each_with_index do |x, row|
  max_row_size = grid.size
  max_col_size = x.size

  x.each_with_index do |_, col|
    print grid[row][col]
    node_pos = "#{row},#{col}"

    if grid[row][col] == 'S'
      start = node_pos
    end
    if grid[row][col] == 'E'
      dest = node_pos
    end
 
    nodes << node_pos
    grid_values[node_pos] = grid[row][col]
    node_siblings[node_pos] ||= []

    if (row + 1) < max_row_size
      node_siblings[node_pos] << "#{row + 1},#{col}"
    end
    if row != 0
      node_siblings[node_pos] << "#{row - 1},#{col}"
    end
    if (col + 1) < max_col_size
      node_siblings[node_pos] << "#{row},#{col + 1}"
    end
    if col != 0
      node_siblings[node_pos] << "#{row},#{col - 1}"
    end
  end
  puts ''
end

puts "\nNodes"
p nodes
puts "\nSiblings"
p node_siblings
puts "\nValues"
p grid_values

grid_values[start] = 'a'
grid_values[dest] = 'z'


puts "Start: #{start}"
puts "Dest: #{dest}"

[nodes, node_siblings, grid_values, start, dest]
end

def valid_move?(prev, n, grid_values)

  unless (grid_values[n].ord - grid_values[prev].ord) <= 1 
    return false
  end

  moves = 0
  if prev.split(',')[0].to_i > n.split(',')[0].to_i
    moves += 1
  end
  if prev.split(',')[0].to_i < n.split(',')[0].to_i
    moves += 1
  end
  if prev.split(',')[1].to_i < n.split(',')[1].to_i
    moves += 1
  end
  if prev.split(',')[1].to_i > n.split(',')[1].to_i
    moves += 1
  end

  moves < 2
end

def bfs(node_siblings, grid_values, start, dest)
  visited = {}

queue = [[start, 0]]
found = false

until queue.empty? || found
  curr = queue.shift
  curr_position = curr[0]

  valid_siblings = node_siblings[curr_position].filter {|sib| valid_move?(curr_position, sib, grid_values)}

  valid_siblings.each do |sibling|
    if sibling == dest
      found = true
      return (curr[1] + 1)
    end

    unless visited.has_key? sibling
      visited[sibling] = true
      queue << [sibling, curr[1] + 1]
    end
  end
end
end

nodes, node_siblings, grid_values, start, dest = init()

bfs(node_siblings, grid_values, start, dest)

starts = nodes.filter {|n| grid_values[n] == 'a'}

res = starts.map {|s| bfs(node_siblings, grid_values, s, dest)}

p res

p res.compact.min
