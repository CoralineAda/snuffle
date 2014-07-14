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
        siblings = nodes.by_type(outer_element.node.type).to_a
        cohort.neighbors = siblings.map do |sibling|
          next unless inner_element = Element::Hash.materialize([sibling]).first
          print "."
          neighbor = cohort.neighbor.new(
            inner_element,
            distance(outer_element.matrix, inner_element.matrix)
          )
          neighbor
        end.compact
        clusters << cohort if cohort.values.count > 1
      end
      clusters
    end

    def distance(primary_matrix, token_matrix)
      Snuffle::Util::Correlation.distance(primary_matrix, token_matrix)
    end

    def hashes
      Element::Hash.materialize(self.nodes.where(type: :hash).to_a.compact)
    end

    def strings
      Element::String.materialize(self.nodes.where(type: :dstr).to_a.compact)
    end



  end

end
