PART_ONE_MARKER_SIZE = 4
PART_TWO_MARKER_SIZE = 14
def calculate_index(marker_size)
  datastream = File.read('input.txt')
  char_group = []
  
  datastream.chars.each_with_index do |char, index|
    if char_group.size == marker_size
      if char_group.size == char_group.uniq.size
        puts index
        break
      end
      char_group.shift
    end
    char_group << char
  end
end

puts "Part 1:"
puts calculate_index PART_ONE_MARKER_SIZE
puts "Part 2:"
puts calculate_index PART_TWO_MARKER_SIZE
