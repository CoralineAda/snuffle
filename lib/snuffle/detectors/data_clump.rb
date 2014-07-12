module Snuffle

  module Detectors

    class DataClump

      attr_accessor :elements

      def initialize(elements=[])
        self.elements = elements
      end

      def cohorts
        clusters.select{|c| c.has_near_neighbors?}.uniq(&:values)
      end

      private

      def clusters
        cohorts = []
        elements.each do |outer_element|
          cohort = Cohort.new(element: outer_element)
          cohort.neighbors = (elements - [outer_element]).map do |inner_element|
             cohort.neighbor.new(inner_element, distance(outer_element.value_matrix, inner_element.value_matrix))
          end
          cohorts << cohort
        end
        cohorts
      end

      def distance(primary_matrix, token_matrix)
        sum = primary_matrix.inject([]){ |a,k| a << (primary_matrix & token_matrix).count ** 2; a}.reduce(:+)
        1.0 / (1 + Math.sqrt(sum)).to_f
      end

    end

  end

end