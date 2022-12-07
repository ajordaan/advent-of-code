def item_priorities
  upper_case_letters = (65..90).map.with_index { |v, i| [ v.chr, i+27 ] }.to_h
  lower_case_letters = (97..122).map.with_index { |v, i| [ v.chr, i+1 ] }.to_h

  upper_case_letters.merge lower_case_letters
end

priorities = item_priorities
total_priority = 0

def part_one
  File.foreach('input.txt') do |line|
  compartment_size = line.size / 2
  first_half = line[0,compartment_size].split ''
  second_half = line[compartment_size, compartment_size].split ''

  repeated_item = (first_half & second_half).first

  total_priority += priorities[repeated_item]
end

puts "TOTAL: #{total_priority}"
end

def part_two
  priorities = item_priorities
  total_priority = 0
  elf_group = []
  line_count = 1
  total_priority = 0

  File.foreach('input.txt') do |line|
    elf_group << line.split('')

    if line_count % 3 == 0
      badge = (elf_group[0] & elf_group[1] & elf_group[2]).first
      total_priority += priorities[badge]
      elf_group = []
    end
    line_count += 1
  end

  puts total_priority
end


part_two
