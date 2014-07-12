module Snuffle
  module Detectors
    class HashClump

      attr_accessor :hashes

      def initialize(hashes=[])
        self.hashes = hashes
      end

      def cohorts
        clusters.map do |cluster|
          [
            cluster[:hash].values.sort,
            cluster[:neighbors].select{|n| n[:distance] < 0.25 }.map{|n| n[:hash].values.sort}
          ].flatten.uniq
        end.uniq.select{|cluster| cluster.size > 1}
      end

      private

      def clusters
        cohorts = []
        hashes.each do |outer_hash|
          cohort = Cohort.new(element: outer_hash)
          (hashes - [outer_hash]).each do |inner_hash|
            cohort.neighbors << [inner_hash, distance(outer_hash.value_matrix, inner_hash.value_matrix)]
          end
          cohorts << cohort
        end
        cohorts
      end

      def calculate_sum(primary_matrix, token_matrix)
        primary_matrix.inject([]){ |a,k| a << (primary_matrix & token_matrix).count ** 2; a}.reduce(:+)
      end

      def distance(primary_matrix, token_matrix)
        (1.0 / (1 + Math.sqrt(calculate_sum(primary_matrix, token_matrix))).to_f)
      end

    end
  end
end