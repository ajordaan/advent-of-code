class Monkey
  def initialize(name:)
    @name = name
    @inspected_items = 0
  end

  attr_accessor :name, :mod, :items, :inspected_items, :operation, :test_division_number, :true_throw_monkey, :false_throw_monkey

  def calculate_worry_level(item)
    @inspected_items += 1
    
    op = @operation.gsub 'old', item.to_s
    worry_level = eval op
    (worry_level.to_i / 3.0).to_i
  end

  def calculate_worry_level_p2(item)
    @inspected_items += 1
    
    op = @operation.gsub 'old', item.to_s
    worry_level = eval op
    worry_level.to_i % @mod
  end

  def test(value)
    value % test_division_number == 0
  end

  def test_p2(value)

  end

  def throw_item(item) 
    monkey = test(item) ? true_throw_monkey : false_throw_monkey

    # puts "item #{item} thrown to monkey #{monkey.name}"
    monkey.catch_item item 
  end

  def catch_item(item)
    @items << item
  end

  def to_s
    "Monkey #{name} inspected items #{inspected_items} times"
  end

end
