module Snuffle
  module Detectors
    class HashClump

      attr_accessor :hashes

      def initialize(hashes=[])
        self.hashes = hashes
      end

      def cohorts
        clusters.select{|c| c.has_near_neighbors?}.map(&:values).uniq
      end

      private

      def clusters
        cohorts = []
        hashes.each do |outer_hash|
          cohort = Cohort.new(element: outer_hash)
          cohort.neighbors = (hashes - [outer_hash]).map do |inner_hash|
             cohort.neighbor.new(inner_hash, distance(outer_hash.value_matrix, inner_hash.value_matrix))
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