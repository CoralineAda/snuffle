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

end
