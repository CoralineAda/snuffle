require 'spec_helper'
require 'pry'

describe Snuffle::CohortDetector do

  let(:file) { File.read("spec/fixtures/program_2.rb") }
  let(:parser) { Snuffle::FileParser.new(file) }
  let(:detector) { Snuffle::CohortDetector.new(parser.hashes) }

  describe "weighting" do

    # attributes are used together as values in a hash
    # E.g. [city, state]
     context "a hash cohort" do

      it "is detected" do
        expect(detector.cohorts.map(&:values)).to eq(
          [
            [:city, :postal_code, :state],
            [:city, :state],
            [:company_name, :customer_name]
          ]
        )
      end

      it "is assigned a weight of X"

    end

    # attributes accessed together in one or more methods
    # E.g. [city, state], [city, state, postal_code]
    context "method cohorts" do
      it "is detected"
      it "is assigned a weight of X"
    end

    # attributes used together in string interpolation
    # E.g. [city, city, postal_code]
    context "string cohorts" do
      it "is detected"
      it "is assigned a weight of X"
    end

  end

end