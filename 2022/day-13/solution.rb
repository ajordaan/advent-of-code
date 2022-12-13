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

    correct_indexes << pair.index if result
    pair.correct_order = result
  end

  puts correct_indexes

  puts correct_indexes.sum

 answer = packets.filter {|p| p.correct_order}.reduce(0) {|sum, pair| sum += pair.index}

 puts answer
end

def compare_packets(left, right)
  puts "TOP: comparing #{left} vs #{right}"

  if left.kind_of?(Integer) && right.kind_of?(Integer)
    puts "Comparing #{left} vs #{right}"
    puts "Left side is smaller, so inputs are in the right order" if left < right
    return true if left < right
    puts "Right side is smaller, so inputs are not in the right order" if left > right
    return false if left > right
   
    return nil
  end

  if left.kind_of?(Array) && right.kind_of?(Array)
    puts "Left side ran out of items so items in the correct order" if left.empty? && right.any?
    return right.any? if left.empty? 
    puts "Right side ran out of items, so inputs are not in the right order" if right.empty? && left.any? 
    return false if right.empty? && left.any? 
    smaller = left.size < right.size ? left.size : right.size

    i = 0
    while i < smaller
      res = compare_packets(left.at(i), right.at(i))
      return res unless res.nil?
      i += 1
    end

    return true if i == left.size && i < right.size
    return false if i == right.size && i < left.size

    return nil
  end

  if left.kind_of?(Array) && right.kind_of?(Integer)
    puts "Mixed types; convert right to [#{right}] and retry comparison"
    return compare_packets(left, [right])
  end

  if left.kind_of?(Integer) && right.kind_of?(Array)
    puts "Mixed types; convert left to [#{left}] and retry comparison"
    return compare_packets([left], right)
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



