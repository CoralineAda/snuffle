require 'pry'
module Snuffle

  class ArgsClump

    include PoroPlus
    attr_accessor :element, :neighbors, :line_numbers

    def self.from(nodes)
      nodes = nodes.method_defs
      clumps = Element::MethodDefinition.materialize(nodes.to_a).inject([]) do |clumps, element|
        clump = ArgsClump.new(element: element, line_numbers: element.node.line_numbers.first )
        if clump.values.count > 1 && clump.near_neighbors.any?
          clumps << clump
        end
        clumps
      end
    end

    def has_near_neighbors?
      near_neighbors.present?
    end

    def near_neighbors
      @near_neighbors ||= neighbors.select{ |n| (n.values & values).size > 0 }
    end

    def neighbors
      @neighbors ||= [element.node.siblings - [self.element.node]].flatten.map{|sibling| Element::MethodDefinition.materialize([sibling]).first}
    end

    def values
      @values ||= self.element.values
    end

    def neighbor
      Struct.new(:element, :distance)
    end

    def distance(primary_matrix, token_matrix)
      Snuffle::Util::Correlation.distance(primary_matrix, token_matrix)
    end

  end

end