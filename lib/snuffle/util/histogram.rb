module Snuffle
  module Util

    class Histogram

      def self.histogram(arrays)
        arrays.flatten.inject({}) { |h, value| h[value] ||= 0; h[value] += 1; h}
      end

    end

  end
end
