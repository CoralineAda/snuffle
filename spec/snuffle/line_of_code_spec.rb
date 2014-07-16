require 'spec_helper'
require 'pry'

describe Snuffle::LineOfCode do

  class SourceFileMock
    include Ephemeral::Base
    collects :lines_of_code, class_name: "Snuffle::LineOfCode"
    attr_accessor :locs
  end

  let(:source_file) { SourceFileMock.new }

  let(:loc_1) { Snuffle::LineOfCode.new(range: (0..24) ) }
  let(:loc_2) { Snuffle::LineOfCode.new(range: (25..34)) }
  let(:loc_3) { Snuffle::LineOfCode.new(range: (35..44)) }

  before do
    source_file.lines_of_code << loc_1
    source_file.lines_of_code << loc_2
    source_file.lines_of_code << loc_3
  end

  describe ".find" do

    it "locates a range within a line" do
      locs = Snuffle::LineOfCode.containing(source_file.lines_of_code, 26, 34)
      expect(locs).to eq([loc_2])
    end

    it "locates a range spanning lines" do
      locs = Snuffle::LineOfCode.containing(source_file.lines_of_code, 26, 42)
      expect(locs).to eq([loc_2, loc_3])
    end

  end

end
