require_relative 'clock_circuit'
CYCLE_MEASURE_INCREMENTS = [20,60,100,140,180,220]

def part_one
  clock = ClockCircuit.new

  File.foreach('input.txt') do |l|
    command = l.split ' '

    command_name = command[0]
    command_value = command[1]&.to_i

    case command_name
    when 'addx'
      clock.tick
      clock.update_register command_value
      clock.tick
    when 'noop'
      clock.tick
    end
  end

  total_signal_strength = 0
  
  for x in CYCLE_MEASURE_INCREMENTS
    puts "Cycle #{x}"
    puts "X = #{clock.cycles[x]}"
    total_signal_strength += clock.signal_strength_at x
  end

  puts "Signal Strengths: "
  puts total_signal_strength
    return clock.cycles
end

def print_cycles(cycles)
  cycles.each_with_index do |value, index|
    next if index == 0
    puts "Cycle #{index}: X = #{value}"
  end
end

def part_one_test
  puts "== TESTING PART ONE =="
  expected_value = 13140
  cycles = part_one

  indexes = [20,60,100,140,180,220]
  expected_values = [21,19,18,21,16,18]

  indexes.each_with_index do |i, k|
    puts "\n== Testing Cycle #{i} =="
    if cycles[i] == expected_values[k]
      puts "PASS".green
    else
      puts "FAIL".red
      puts "Expected #{expected_value}, got #{cycles[i]}"
    end

  end
  # if result == expected_value
  #   puts "PASS".green
  # else  
  #   puts "FAIL".red
  #   puts "Expected #{expected_value}, got #{result}"
  # end

  puts "======================"
end


class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

part_one
