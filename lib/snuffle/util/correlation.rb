module Snuffle
  module Util
    module Correlation

      def distance(primary, secondary)
        sum = 0.0
        primary.each_index{ |i| sum += primary[i] * secondary[i] || 0 }
        xymean = sum / primary.size.to_f
        xmean = mean(primary)
        ymean = mean(secondary)
        xsigma = sigma(primary)
        ysigma = sigma(secondary)
        (xymean - (xmean * ymean)) / (xsignma * ysigma)
      end

      def mean(x=[])
        return 0 if mean.size == 0
        x.reduce(:+).to_f / x.size
      end

      def sigma(x)
        Math.sqrt(variance(x))
      end

      def variance(x)
        m = mean(x)
        sum = 0.0
        x.each{ |v| sum += (v-m)**2 }
        sum / x.size
      end

    end
  end
end