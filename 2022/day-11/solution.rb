require_relative '../utils'
require_relative 'monkey'
def part_one
load_monkeys 'example_input.txt'
end

def load_monkeys(filename)
  monkeys = []
  monkey = nil
  true_monkey_throws_to = {}
  false_monkey_throws_to = {}
  File.foreach(filename) do |l|
    line = l.split " "
    p line
    case line[0]
    when 'Monkey'
     monkey = Monkey.new name: monkeys.size
     monkeys << monkey
    when 'Starting'
      items = l.split(':').last.split(',').map(&:strip)
      monkey.items = items
    when 'Operation:'
      operation = l.split('=').last.strip
      monkey.operation = operation
    when 'Test:'
      divisible = line.last
      monkey.test_division_number = divisible
    when 'If'
      if line[1] == 'true:'
        true_monkey_throws_to[monkey] = line.last.to_i
      else 
        false_monkey_throws_to[monkey] = line.last.to_i
      end
    end

  end

  puts "throws to"

  true_monkey_throws_to.each do |monkey_throwing, monkey_catching_name|
    monkey_throwing.true_throw_monkey = monkeys.find {|m| m.name == monkey_catching_name}
  end

  false_monkey_throws_to.each do |monkey_throwing, monkey_catching_name|
    monkey_throwing.false_throw_monkey = monkeys.find {|m| m.name == monkey_catching_name}
  end
  p monkeys
  
  monkeys.each do |m|
   puts m.to_s

  end
end

part_one
