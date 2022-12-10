class SystemFile
  attr_accessor :size, :name

  def initialize(name:, size:)
    @size = size.to_i
    @name = name
  end

  def total_size
    @size
  end

  def to_s
    { name: name }
  end

  def to_detailed_s
    to_s.merge({size: size})
  end
end
