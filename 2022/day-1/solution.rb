current_elf_calories = 0
all_calories = []
File.foreach('input.txt') do |line|
  if line.size <= 1
    all_calories << current_elf_calories
    current_elf_calories = 0
  else
    current_elf_calories += line.to_i
  end
end

all_calories << current_elf_calories

puts 'Max calories:'
puts all_calories.max

puts 'Sum of top 3 highest calories'
puts all_calories.max(3).sum
