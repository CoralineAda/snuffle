require 'spec_helper'
require 'pry'

describe Snuffle::Element::Hash do

  let(:hash) { Snuffle::Element::Hash.new(nil) }

  describe "#pairs" do
    it "creates hash pairs from its keys and values" do
      expect(hash).to receive(:keys) {[:foo, :bar]}
      expect(hash).to receive(:values) {[1, 2]}
      expect(hash.pairs).to eq({foo: 1, bar: 2})
    end
  end

end