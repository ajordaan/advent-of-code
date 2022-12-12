class ClockCircuit
  CRT_ROW_SIZE = 40

  def initialize(x: 1, debug: false)
    @x = x
    @cycles = [0, @x]
    @crt_rows = []
    @current_crt_row = ''
    @debug = debug
  end

  attr_reader :cycles, :x, :crt_rows, :current_crt_row

  def current_cycle
    @cycles.size - 1
  end

  def tick(value = nil)
    draw_pixel
    update_register(value) unless value.nil?
    @cycles << x
  end

  def draw_pixel
    if @current_crt_row.size == CRT_ROW_SIZE
      @crt_rows << @current_crt_row
      @current_crt_row = ''
    end

    pixel_number = (current_cycle - 1) % CRT_ROW_SIZE
    puts "Drawing pixel in position #{pixel_number}" if @debug

    if sprite_position.include? pixel_number 
      @current_crt_row += '#'
    else
      @current_crt_row += '.'
    end

    puts "Current CRT row: #{@current_crt_row}" if @debug
  end

  def finish_drawing_pixels
    @crt_rows << @current_crt_row
  end

  def sprite_position
    [x-1, x, x+1]
  end

  def signal_strength_at(index)
    index * @cycles[index]
  end

  def update_register(value)
    puts "X updated to #{value}" if @debug
    @x += value
  end
end
