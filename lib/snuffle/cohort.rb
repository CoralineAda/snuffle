module Snuffle

  class Cohort

    include PoroPlus
    attr_accessor :element, :neighbors

    def has_near_neighbors?
      near_neighbors.present?
    end

    def near_neighbors
      neighbors.select{|n| n.distance <= 1.0}
    end

    def neighbor=(element, distance)
      @neighbors << neighbor(element, distance)
    end

    def values
      self.element.values.map(&:to_s).sort
    end

    def neighbor
      Struct.new(:element, :distance)
    end

    def neighbors
      @neighbors ||= []
    end

  end

end