require_relative '../utils'
PacketPair = Struct.new(:left, :right, :index, :correct_order)

def part_one
  packets = load_packets 'example_input.txt'
  
  packets.each do |pair|
    
  end

end

def compare_packets(left, right)
  puts "TOP: comparing #{left} vs #{right}"
  if left.empty?
    puts "LEFT EMPTY"
    p right
  end
  return right.any? if left.empty? 

  return false if right.empty? && left.any?

  left_val = left.first
  right_val = right.first
  if left_val.kind_of?(Integer) && right_val.kind_of?(Integer)
    return true if left_val < right_val
    return false if left_val > right_val

    left.shift
    right.shift

    return compare_packets(left, right)
  end
   print 'left val '
   p left_val
   print 'right val: '
   p right_val

  if left_val.kind_of?(Array) && right_val.kind_of?(Array)

    return compare_packets(left_val, right_val)
  end

  if left_val.kind_of?(Array) && right_val.kind_of?(Integer)
    return compare_packets(left_val, [right_val])
  end

  if left_val.kind_of?(Integer) && right_val.kind_of?(Array)
    return compare_packets([left_val], right_val)
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

    if result == expected_values[pair.index]
      puts "PASS".green
    else
      puts "Expected #{expected_values[pair.index]}, got #{result}"
      puts "FAIL".red
    end
  end
end

# load_packets 'example_input.txt'

compare_packets_test
