require_relative '../utils'
require_relative 'monkey'

MAX_ROUNDS = 10000

def part_one

  starting = Time.now


  monkeys = load_monkeys 'input.txt'

  1.upto(MAX_ROUNDS) do |round|
    monkeys.each do |monkey|
      monkey.items.each do |item|
        worry_level = monkey.calculate_worry_level_p2 item
        monkey.throw_item worry_level
      end
      monkey.items = []
    end
    print_monkeys monkeys if round % 1000 == 0 || round == 20 || round == 1
  end

  ending = Time.now
elapsed = ending - starting
 
monkeys.sort! {|a,b| b.inspected_items <=> a.inspected_items}

monkeys.each {|m| p [m.name, m.inspected_items]}
puts "\n"
puts (monkeys[0].inspected_items * monkeys[1].inspected_items)

puts "Time Taken: #{elapsed.to_i} seconds"

end

def print_monkeys(monkeys)
  monkeys.each {|m| puts m}
  puts ''
end

def load_monkeys(filename)
  monkeys = []
  monkey = nil
  true_monkey_throws_to = {}
  false_monkey_throws_to = {}
  mod = 1
  File.foreach(filename) do |l|
    line = l.split " "

    case line[0]
    when 'Monkey'
     monkey = Monkey.new name: monkeys.size
     monkeys << monkey
    when 'Starting'
      items = l.split(':').last.split(',').map(&:strip).map(&:to_i)
      monkey.items = items
    when 'Operation:'
      operation = l.split('=').last.strip
      monkey.operation = operation
    when 'Test:'
      divisible = line.last.to_i
      monkey.test_division_number = divisible
      mod *= divisible
    when 'If'
      if line[1] == 'true:'
        true_monkey_throws_to[monkey] = line.last.to_i
      else 
        false_monkey_throws_to[monkey] = line.last.to_i
      end
    end
  end

  monkeys.each {|m| m.mod = mod}

  true_monkey_throws_to.each do |monkey_throwing, monkey_catching_name|
    monkey_throwing.true_throw_monkey = monkeys.find {|m| m.name == monkey_catching_name}
  end

  false_monkey_throws_to.each do |monkey_throwing, monkey_catching_name|
    monkey_throwing.false_throw_monkey = monkeys.find {|m| m.name == monkey_catching_name}
  end

  monkeys
end

part_one
