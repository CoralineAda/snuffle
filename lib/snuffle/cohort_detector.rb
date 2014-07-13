module Snuffle

  class CohortDetector

    attr_accessor :nodes

    def initialize(input_nodes)
      self.nodes = input_nodes
    end

    def cohorts
      clusters.select{|cluster| cluster.has_near_neighbors?}.uniq(&:values)
    end

    private

    def elements
      [hashes, strings].flatten.compact
    end

    def clusters
      clusters = []
      elements.each do |outer_element|
        cohort = Cohort.new(element: outer_element)
        cohort.neighbors = (elements - [outer_element]).map do |inner_element|
           cohort.neighbor.new(
             inner_element,
             distance(outer_element.value_matrix, inner_element.value_matrix)
            )
        end
        clusters << cohort if cohort.values.count > 1
      end
      clusters
    end

    def distance(primary_matrix, token_matrix)
      Snuffle::Util::Correlation.distance(primary_matrix, token_matrix)
    end

    def hashes
      Element::Hash.materialize(self.nodes.where(type: :hash).to_a)
    end

    def strings
      Element::String.materialize(self.nodes.where(type: :dstr).to_a)
    end

  end

end
