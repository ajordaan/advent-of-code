class Monkey
  def initialize(name:)
    @name = name
  end

  attr_accessor :name, :items, :operation, :test_division_number, :true_throw_monkey, :false_throw_monkey

  def calculate_worry_level(item)
    op = @operation.gsub 'old', item
    worry_level = eval op

    (worry_level / 3.0).round
  end

  def throw_item_to(item, monkey)
    monkey.catch_item item 
  end

  def catch_item(item)
    @items << item
  end

  def to_s
    "Name: #{name}\nItems: #{items}\nTrue throw: #{true_throw_monkey.name}\nFalse Throw: #{false_throw_monkey.name}}"
  end

end
