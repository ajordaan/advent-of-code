require_relative 'node'
require_relative '../utils'

def valid_move?(prev, n)
  moves = 0
  if prev.split('')[0].to_i > n.split('')[0].to_i
    moves += 1
  end
  if prev.split('')[0].to_i < n.split('')[0].to_i
    moves += 1
  end
  if prev.split('')[1].to_i < n.split('')[1].to_i
    moves += 1
  end
  if prev.split('')[1].to_i > n.split('')[1].to_i
    moves += 1
  end

  moves < 2
end

grid = File.readlines('example_input.txt').map {|line| line.strip.chars}
p grid
nodes = []
id = 1

grid_values = {}
node_sibling_hash = {}
grid.each_with_index do |x, row|
  max_row_size = grid.size
  max_col_size = x.size

  x.each_with_index do |_, col|
    print grid[row][col]

    grid_values["#{row}#{col}"] = grid[row][col]
    node_sibling_hash["#{row}#{col}"] ||= []
    id += 1

    p nodes
    n = nodes.find {|no| no.row == row && no.col == col } || Node.new( value: grid[row][col], row: row, col: col, id: id)
    puts "Current Node ID: #{n.id}"
    puts "#{row}, #{col}"

    if (row + 1) < max_row_size
      sib = Node.new(value: grid.at(row + 1).at(col), row: row + 1, col: col, id: id)
      
      id += 1 
      existing_sib = nodes.find {|no| no.row == (row + 1) && no.col == (col)  }
      puts "found existing" if existing_sib
      n.add_sibling(row + 1, col)

    end
    if row != 0
      sib = Node.new(value: grid.at(row - 1).at(col), row: row - 1, col: col, id: id)
      id += 1
      existing_sib = nodes.find {|no| no.row == (row-1) && no.col == (col)  }
      puts "found existing" if existing_sib
      n.add_sibling(row - 1, col)
    end
    if (col + 1) < max_col_size
      sib = Node.new(value: grid.at(row).at(col + 1), row: row, col: col + 1, id: id)
      id += 1
      existing_sib = nodes.find {|no| no.col == (col+1) && no.row == row  }
      puts "found existing" if existing_sib
      n.add_sibling(row, col + 1)
    end
    
    if col != 0
      sib = Node.new(value: grid.at(row).at(col - 1), row: row, col: col - 1, id: id)
      existing_sib = nodes.find {|no| no == sib  }
      puts "found existing" if existing_sib
      n.add_sibling(row, col - 1)
    end

   nodes << n

   puts "Added #{n}"

   id += 1
  end
  puts ''
  puts "SS #{nodes.first.siblings.first}"
end
puts "SS #{nodes.first.siblings.first}"


puts nodes

p grid_values

grid_values["00"] = 'a'
puts "\nBFS\n"

queue = [nodes.first.position]
visited_nodes = []
path = []

until queue.empty?
  n = queue.shift
  while !path.empty? && !valid_move?(path.last, n)
    n = queue.shift
  end
  

  if !path.empty?
    prev = path.last
    if prev.split('')[0].to_i > n.split('')[0].to_i
      puts "Moving Up"
    end
    if prev.split('')[0].to_i < n.split('')[0].to_i
      puts "Moving Down"
    end
    if prev.split('')[1].to_i < n.split('')[1].to_i
      puts "Moving Right"
    end
    if prev.split('')[1].to_i > n.split('')[1].to_i
      puts "Moving Left"
    end
  else
    puts "Start"
  end

  puts "Visiting #{grid_values[n]} (#{n})"
  break if grid_values[n] == 'E'
 
  visited_nodes << n
  path << n
  for sibling in nodes.find { |no| no.position == n }.siblings

    if grid_values[sibling] == 'E'
      break
    end
    sibling_val = grid_values[sibling]
    sibling_val = 'z' if grid_values[sibling] == 'E'
    unless visited_nodes.include?(sibling) || ((grid_values[n].ord - sibling_val.ord) < -1 )
      queue << sibling
      visited_nodes << sibling
    end
   
  end
end

path.each {|v| print "#{grid_values[v]} -> "}
puts ''
puts path.size
 