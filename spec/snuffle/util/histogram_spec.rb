require 'spec_helper'

describe Snuffle::Util::Histogram do

  describe ".from" do

    it "creates a histogram" do
      arrays = [
        ['a', 'b', 'b', 'c', 'c', 'c', 'd', 'd', 'd', 'd'],
        ['a', 'b', 'c', 'd']
      ]
      results = Snuffle::Util::Histogram::from(arrays)
      expect(results).to eq(
        {
          'a' => 2,
          'b' => 3,
          'c' => 4,
          'd' => 5
        }
      )
    end

  end

end
