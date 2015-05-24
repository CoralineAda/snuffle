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
    begin
      return [] unless node && node.children.objects.any?
      node.children.objects[1].children.map{|child| child.name}.flatten
    rescue
      []
    end
  end


end
