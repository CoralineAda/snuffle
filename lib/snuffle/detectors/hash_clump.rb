module Snuffle
  module Detectors
    module HashClump

      attr_accessor :hashes

      def initialize(hashes={})
        self.hashes = hashes
      end

      def cohorts(type=:values)
        overlapping(hashes)[type].keys
      end

      def overlapping
        {
          keys:   Snuffle::Util::Histogram.from(self.hashes.map(&:keys)).select{|k,v| v > 1},
          values: Snuffle::Util::Histogram.from(self.hashes.map(&:values)).select{|k,v| v > 1}
        }
      end

    end
  end
end