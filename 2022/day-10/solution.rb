require_relative 'clock_circuit'
require_relative '../utils'

CYCLE_MEASURE_INCREMENTS = [20,60,100,140,180,220]
CRT_ROW_SIZE = 40
DEBUG = FALSE
def part_one
  clock = ClockCircuit.new debug: DEBUG

  File.foreach('example_input.txt') do |l|
    command = l.split ' '

    log "Cycle: #{clock.current_cycle}"

    command_name = command[0]
    command_value = command[1]&.to_i

    case command_name
    when 'addx'
      clock.tick
      clock.tick command_value
    when 'noop'
      clock.tick
    end
  end

  clock.finish_drawing_pixels

  puts "=== CRT ==="

  clock.crt_rows.each {|row| puts row}

  total_signal_strength = 0
  
  for x in CYCLE_MEASURE_INCREMENTS
    log "Cycle #{x}"
    log "X = #{clock.cycles[x]}"
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

def log(s)
  puts s if DEBUG
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
  puts "======================"
end

part_one
