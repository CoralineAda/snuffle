module Snuffle

  class CohortDetector

    attr_accessor :nodes

    def initialize(input_nodes)
      self.nodes = input_nodes
    end

    def cohorts
      @cohorts ||= clusters.select{|cluster| cluster.has_near_neighbors?}.uniq(&:values)
    end

    private

    def elements
      @elements ||= [hashes, strings].flatten.compact
    end

    def clusters
      clusters = []
      elements.to_a.each do |outer_element|
        cohort = Cohort.new(element: outer_element)
        next unless cohort.values.count > 1
        clusters << cohort if cohort.near_neighbors.count > 1
      end
      clusters
    end

    def hashes
      Element::Hash.materialize(self.nodes.where(type: :hash).to_a.compact)
    end

    def strings
      Element::String.materialize(self.nodes.where(type: :dstr).to_a.compact)
    end

  end

end
