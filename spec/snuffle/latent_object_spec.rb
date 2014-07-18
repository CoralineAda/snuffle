require 'spec_helper'

describe Snuffle::LatentObject do

  let(:program_2) { Snuffle::SourceFile.new(path_to_file: "spec/fixtures/latent_object_fixture.rb") }

  describe ".from" do

    let(:results) { Snuffle::LatentObject.from(program_2.nodes) }

    it "returns an array of LatentObject instances" do
      expect(results.first.class.name).to eq "Snuffle::LatentObject"
    end

    it "returns instances with object candidates" do
      expect(results.first.object_candidate).to eq "user"
    end

    it "returns instances with source methods" do
      expect(results.first.source_methods).to eq ["user_name", "user_address", "user_email"]
    end

  end

  describe ".potential_objects_with_methods" do

    let(:results) { Snuffle::LatentObject.potential_objects_with_methods(program_2.nodes) }

    it "finds repeated words " do
      expect(results.keys).to eq(["user"])
    end

    it "finds methods that repeated words appear in" do
      expect(results['user']).to eq(["user_name", "user_address", "user_email"])
    end

  end

end