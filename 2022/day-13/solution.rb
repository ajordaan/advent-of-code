require_relative '../utils'
PacketPair = Struct.new(:left, :right, :index, :correct_order)

def part_one
  packets = load_packets 'input.txt'
 correct_indexes = []
  packets.each do |pair|
    puts "\n== Pair #{pair.index} =="

    puts "Compare #{pair.left} vs #{pair.right}"
    result = compare_packets(pair.left, pair.right) 
    puts "\n#{result}\n"

    correct_indexes << pair.index if result == -1
    pair.correct_order = result == -1
  end

  answer = packets.filter {|p| p.correct_order}.reduce(0) {|sum, pair| sum += pair.index}

  puts answer
end

def part_two
  all_packets = []
  packets = load_packets 'input.txt'
  correct_indexes = []
  packets.each do |pair|
    all_packets << pair.left
    all_packets << pair.right
  end

  all_packets.append([[2]])
  all_packets.append([[6]])

  sorted = all_packets.sort {|a,b| compare_packets(a,b) }

  p2_answer = (sorted.find_index([[2]]) + 1) * (sorted.find_index([[6]]) + 1)

  puts p2_answer
end

def compare_packets(left, right)
  puts "TOP: comparing #{left} vs #{right}"

  if left.kind_of?(Integer) && right.kind_of?(Integer)
   if left < right
    return -1
   elsif left == right
    return 0
   else
    return 1
   end
  end

  if left.kind_of?(Array) && right.kind_of?(Array)
    i = 0

    while i< left.size && i < right.size
      c = compare_packets(left[i], right[i])

      if c == -1
        return -1
      end
      if c == 1
        return 1
      end

      i += 1
    end

    if i == left.size && i < right.size
      return -1
    elsif i == right.size && i < left.size
      return 1
    else
      return 0
    end
  end

  if left.kind_of?(Array) && right.kind_of?(Integer)
    return compare_packets left, [right]
  end

  if left.kind_of?(Integer) && right.kind_of?(Array)
    return compare_packets [left], right
  end

end

def load_packets(filename)
  packets = []
  pair = PacketPair.new
  index = 1
  File.foreach(filename) do |l|
    if l == "\n"
      packets << pair
      pair = PacketPair.new
      index += 1
    else
      pair.index = index
      if pair.left.nil?
        pair.left = eval l.strip
      else
        pair.right = eval l.strip 
      end
    end

  end

  packets << pair

  p packets

  packets
end

def compare_packets_test
  packets = load_packets 'example_input.txt'
  expected_values = [0, true, true, false, true, false, true, false, false]

  packets.each do |pair|
    puts "\n== Pair #{pair.index} =="

    puts "Compare #{pair.left} vs #{pair.right}"
    result = compare_packets(pair.left, pair.right) 
    puts "\n#{result}\n"
    pair.correct_order = result
    if result == expected_values[pair.index]
      puts result
      puts "PASS".green
    else
      puts "Expected #{expected_values[pair.index]}, got #{result}"
      puts "FAIL".red
    end
  end

 answer = packets.filter {|p| p.correct_order}.reduce(0) {|sum, pair| sum += pair.index}

 puts answer
end

# compare_packets_test

part_one



