module Snuffle

  class Cohort

    include PoroPlus
    attr_accessor :element, :neighbors, :line_numbers

    def self.from(nodes)
      nodes = nodes.non_sends.hashes
      cohorts = Element::Hash.materialize(nodes.to_a).inject([]) do |cohorts, element|
        cohort = Cohort.new(element: element, line_numbers: element.node.line_numbers )
        if cohort.values.count > 1 && cohort.near_neighbors.count > 0
          cohorts << cohort
        end
        cohorts
      end
    end

    def has_near_neighbors?
      near_neighbors.present?
    end

    def near_neighbors
      @near_neighbors ||= neighbors.select{ |n| (n.values & values).size == values.size }
    end

    def neighbors
      @neighbors ||= [element.node.siblings - [self.element.node]].flatten.map{|sibling| Element::Hash.materialize([sibling]).first}
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