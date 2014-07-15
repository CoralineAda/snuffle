require 'spec_helper'
require 'pry'

describe Snuffle::SourceFile do

  let(:program_2) {Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_2.rb") }
  let(:program_3) {Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_3.rb") }

  describe "weighting" do

    # attributes are used together as values in a hash
    # E.g. [city, state]
     context "a hash cohort" do

      # Example Case: hash hit with attr_accessor match
      # Fixture file contains two instances of city, postal_code, state
      # One is args to attr_accessor, one is args hash to method
      it "does not match hash values with non-hash values" do
        args = ['city', 'postal_code', 'state']
        values = program_2.summary.object_candidates
        p values
        expect(values.include?(args)).to be_falsey
      end

      it "matches elements with different parents" do
        args = ['company_name', 'customer_name']
        values = program_3.summary.object_candidates
        expect(values.include?(args)).to be_truthy
      end

      xit "is detected" do
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