class Directory
  attr_accessor :parent, :name, :children
  def initialize(name:, parent:)
    @parent = parent
    @children = []
    @name = name
  end

  def add_child(child)
    @children << child
  end

  def total_size
    @children.sum { |child| child.total_size }
  end

  def path
    curr_dir = parent
    path_str = [name]

    while curr_dir
      path_str << curr_dir.name
      curr_dir = curr_dir.parent
    end

    path_str.reverse.join '->'
  end

  def to_s
    { name: name, path: path }
  end

  def to_detailed_s
    to_s.merge({parent: parent.to_s, total_size: total_size, children: children.map(&:to_s)})
  end
end
