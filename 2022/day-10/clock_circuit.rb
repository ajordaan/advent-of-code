class ClockCircuit
  def initialize(x: 1)
    @x = x
    @cycles = [0, @x]
  end

  attr_reader :cycles, :x

  def current_cycle
    @cycles.size - 1
  end

  def tick
    @cycles << @x
  end

  def signal_strength_at(index)
    index * @cycles[index]
  end

  def update_register(value)
    @x += value
  end
end
