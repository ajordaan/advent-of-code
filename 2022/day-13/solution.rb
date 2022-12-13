require_relative '../utils'
PacketPair = Struct.new(:left, :right, :index, :correct_order)

def part_one
  packets = load_packets 'input.txt'

  packets.each do |pair|
    
    larger = pair.left.size >= pair.right.size ? pair.left : pair.right

   puts "\n== Pair #{pair.index} =="

   puts "Compare #{pair.left} vs #{pair.right}"
   result = larger.each_with_index.map do |_, i|
     puts "\n==IN Map=="
     puts "Comparing at index #{i}"
     print "left[i] = "
     p pair.left[i]
     print "right[i] = "
     p pair.right[i]
     puts ''
     compare_packets(pair.left[i] || [], pair.right[i] || [], pair.left, pair.right)
   end 

   pair.correct_order = result.compact.first
 end

answer = packets.filter {|p| p.correct_order}.reduce(0) {|sum, pair| sum += pair.index}

puts answer
end

def compare_packets(left, right, left_parent = nil, right_parent = nil, index = 0)
  puts "TOP: comparing #{left} vs #{right}"
  puts "Left parent: #{left_parent}"
  puts "Right parent: #{right_parent}"
  if left.kind_of?(Integer) && right.kind_of?(Integer)
    puts "Left side is smaller, so inputs are in the right order" if left < right
    return true if left < right
    puts "Right side is smaller, so inputs are not in the right order" if left > right
    return false if left > right
    puts "Numbers equal"
    index += 1
    puts "LEft index: #{index}"
    puts "Right index: #{index}"
    puts "LEft next: #{left_parent&.at(index)}"
    puts "Right next: #{right_parent&.at(index)}"

    return compare_packets(left_parent&.at(index),right_parent&.at(index), left_parent, right_parent, index) if !left_parent&.at(index).nil? && !right_parent&.at(index).nil?
  
  end

  if left.kind_of?(Array) && right.kind_of?(Array)
    puts "Left side ran out of items so items in the correct order" if left.empty? && right.any?
    return right.any? if left.empty? 
puts "Right side ran out of items, so inputs are not in the right order" if right.empty? && left.any? 
    return false if right.empty? && left.any?
    return compare_packets(left.first, right.first, left_parent = left, right_parent = right)
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
    
     larger = pair.left.size >= pair.right.size ? pair.left : pair.right

    puts "\n== Pair #{pair.index} =="

    puts "Compare #{pair.left} vs #{pair.right}"
    result = larger.each_with_index.map do |_, i|
      puts "\n==IN Map=="
      puts "Comparing at index #{i}"
      print "left[i] = "
      p pair.left[i]
      print "right[i] = "
      p pair.right[i]
      puts ''
      compare_packets(pair.left[i] || [], pair.right[i] || [], pair.left, pair.right)
    end 

    pair.correct_order = result.compact.first
    if result.compact.first == expected_values[pair.index]
      puts result
      puts "PASS".green
    else
      puts "Expected #{expected_values[pair.index]}, got #{result.compact.first}"
      puts "FAIL".red
    end
  end

 answer = packets.filter {|p| p.correct_order}.reduce(0) {|sum, pair| sum += pair.index}

 puts answer
end

# compare_packets_test

part_one



