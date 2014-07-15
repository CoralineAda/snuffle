module Snuffle

  class Cohort

    include PoroPlus
    attr_accessor :element, :neighbors

    MAX_NEIGHBOR_DISTANCE = 3.0

    def has_near_neighbors?
      near_neighbors.present?
    end

    def near_neighbors
      @near_neighbors ||= neighbors.select{|n| n.distance <= MAX_NEIGHBOR_DISTANCE && n.distance > 0}
    end

    def neighbors
      @neighbors ||= element.node.siblings.map do |sibling|
        sibling_element = Element::Hash.materialize([sibling]).first
        neighbor.new(sibling_element, distance(element.matrix, sibling_element.matrix))
      end
    end

    def values
      self.element.values.map(&:to_s).sort
    end

    def neighbor
      Struct.new(:element, :distance)
    end

    def distance(primary_matrix, token_matrix)
      Snuffle::Util::Correlation.distance(primary_matrix, token_matrix)
    end

  end

end