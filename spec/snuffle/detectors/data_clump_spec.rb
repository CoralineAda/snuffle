require 'spec_helper'
require 'pry'

describe Snuffle::Detectors::DataClump do

  let(:code) { File.read("spec/fixtures/program_1.rb") }

  let(:detector) { Snuffle::Detectors::DataClump.new(code) }

  describe "#hashes" do
    it "finds all hashes" do
      hashes = detector.hashes
      p hashes
      expect(hashes.count).to eq(2)
    end
  end

  describe "#hash_keys" do
    it "finds all hash keys" do

    end

  end

end