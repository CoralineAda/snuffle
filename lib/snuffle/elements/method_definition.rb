class Snuffle::Element::MethodDefinition

  attr_accessor :node

  def self.materialize(nodes=[])
    nodes.each.map{|node| new(node) }
  end

  def initialize(node)
    self.node = node
  end

  def method_name
    node.name
  end

  def values
    return [] unless node.children.objects.any?
    args = node.children.objects[1].children.map{|child| child.name}.flatten
    args
  end


end
